Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B11D6FD7D7
	for <lists+kvmarm@lfdr.de>; Fri, 15 Nov 2019 09:24:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 334F84AF02;
	Fri, 15 Nov 2019 03:24:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.908
X-Spam-Level: 
X-Spam-Status: No, score=0.908 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@armh.onmicrosoft.com
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@armh.onmicrosoft.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aBxzWkZjGcqD; Fri, 15 Nov 2019 03:24:48 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CBAEB4AF01;
	Fri, 15 Nov 2019 03:24:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E94834AEC8
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 Nov 2019 03:24:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wm-phdmAx0r0 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 15 Nov 2019 03:24:44 -0500 (EST)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50059.outbound.protection.outlook.com [40.107.5.59])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0DC5A4AEAA
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 Nov 2019 03:24:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqONU9aIxyPtotpVZqCYAhzJULEraZFes6JCG8txzZs=;
 b=hlJSNoMLnNJpyym+QB8FBKB2pBYZwsqecWw0YNqGF9hjLLl1yq8jgKd89OLOqS9o6ObFNxjmc9j44CGg8pPDLdAuhsA3KEsqXxyR32T4DLoDzOiKxUh1Ld7orOcVxid8sCK9AochL2BSqccYvtI+UVz5eIyfcj7HIkdOdh9tWpg=
Received: from HE1PR0802CA0009.eurprd08.prod.outlook.com (2603:10a6:3:bd::19)
 by DB6PR0802MB2549.eurprd08.prod.outlook.com (2603:10a6:4:a0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22; Fri, 15 Nov
 2019 08:24:42 +0000
Received: from DB5EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by HE1PR0802CA0009.outlook.office365.com
 (2603:10a6:3:bd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22 via Frontend
 Transport; Fri, 15 Nov 2019 08:24:42 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.cs.columbia.edu; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.cs.columbia.edu; dmarc=none
 action=none header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT037.mail.protection.outlook.com (10.152.20.215) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Fri, 15 Nov 2019 08:24:41 +0000
Received: ("Tessian outbound 3fba803f6da3:v33");
 Fri, 15 Nov 2019 08:24:39 +0000
X-CR-MTA-TID: 64aa7808
Received: from de50c3b770ee.2 (cr-mta-lb-1.cr-mta-net [104.47.6.54])
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 D7401C03-0FEA-4BBB-B8B7-D77B23F631F7.1; 
 Fri, 15 Nov 2019 08:24:34 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2054.outbound.protection.outlook.com [104.47.6.54])
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id de50c3b770ee.2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Fri, 15 Nov 2019 08:24:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFG+r2n8zfADuoUg9Ph7IkzLi7et3xzqZfemxf8fUweGofHXrYt7NsTklTDDPXM6s/71MSZ1Dhxzb2NkqNLq+Qj79h+6hR7Rwcjr+TDAJmJmjypeq/z4Tj+8hTSlTWCC5ClOrL+9Wno03LxOSJFmXDyc2SedGN1L1dakfXdI49EGaELHlk0WnRa0ctwr+dEswb4R5JyAeSkN3JvTSZJKRprGJFKc9BL+c87vF8XNNytZf3V6y2n1XoU2oMTLVpl5U86TlzYqYpb7jloaWYaGPQnHxZdLZcJUJ0dQs9e6GHtcxXXTKasKZ71Z45uOutA5R0A7ATWKhP6NKeEkLN98Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqONU9aIxyPtotpVZqCYAhzJULEraZFes6JCG8txzZs=;
 b=Pv+J2L7iUg+1jK4bs+NbdOTbj6EyVeA3axuVzEjA89dXh3+GLd2L+DAcXTsHsnyeoMI0oKbgAYcFvDTfC6p1QqOsKgXi2Jj9rt7sYKD/cHhX90+MFIs/FVw8enlMbgvMEtTU9C5yMKDp78fwnU85VRcuMvcKQc+WVpS7cOZgICNQvmGFF/OIuEbiFOkKlo6tGwJdz056H9QeyHxkfL6+rnLDactPSl2shaqKVOnpsb0IwtiSShj4MzpwDIhADago9bWkVeCuEQYjVwPlR492ggzH9mLHOPQ2ez6H0QqbSx40XAvARAOvErY138nGpCi/kuOultQQPbNrYgo299Abuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqONU9aIxyPtotpVZqCYAhzJULEraZFes6JCG8txzZs=;
 b=hlJSNoMLnNJpyym+QB8FBKB2pBYZwsqecWw0YNqGF9hjLLl1yq8jgKd89OLOqS9o6ObFNxjmc9j44CGg8pPDLdAuhsA3KEsqXxyR32T4DLoDzOiKxUh1Ld7orOcVxid8sCK9AochL2BSqccYvtI+UVz5eIyfcj7HIkdOdh9tWpg=
Received: from VI1PR0801MB1677.eurprd08.prod.outlook.com (10.168.64.21) by
 VI1PR0801MB1807.eurprd08.prod.outlook.com (10.168.61.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 15 Nov 2019 08:24:32 +0000
Received: from VI1PR0801MB1677.eurprd08.prod.outlook.com
 ([fe80::dc15:dc7b:57ad:d978]) by VI1PR0801MB1677.eurprd08.prod.outlook.com
 ([fe80::dc15:dc7b:57ad:d978%8]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 08:24:32 +0000
From: "Jianyong Wu (Arm Technology China)" <Jianyong.Wu@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [RFC PATCH v7 4/7] time: Add mechanism to recognize clocksource
 in time_get_snapshot
Thread-Topic: [RFC PATCH v7 4/7] time: Add mechanism to recognize clocksource
 in time_get_snapshot
Thread-Index: AQHVmuUeY8KwMfywA063cJuUDSewUaeKtyGAgAEslGA=
Date: Fri, 15 Nov 2019 08:24:32 +0000
Message-ID: <VI1PR0801MB16770B5FEF32B82E7B81251EF4700@VI1PR0801MB1677.eurprd08.prod.outlook.com>
References: <20191114121358.6684-1-jianyong.wu@arm.com>
 <20191114121358.6684-5-jianyong.wu@arm.com>
 <alpine.DEB.2.21.1911141507010.2507@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911141507010.2507@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 62d86767-0af9-4fac-8287-f19c350689aa.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Jianyong.Wu@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a68c049-91f1-45d6-587e-08d769a54348
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1807:|VI1PR0801MB1807:|DB6PR0802MB2549:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB25496641C5BAE41C323B7211F4700@DB6PR0802MB2549.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 02229A4115
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(13464003)(256004)(71190400001)(11346002)(6916009)(446003)(14454004)(66066001)(5660300002)(74316002)(305945005)(2906002)(7736002)(476003)(76176011)(53546011)(52536014)(6506007)(55236004)(186003)(7696005)(7416002)(486006)(102836004)(26005)(54906003)(25786009)(66946007)(316002)(478600001)(66556008)(99286004)(86362001)(64756008)(76116006)(66476007)(4326008)(66446008)(6436002)(8936002)(3846002)(6116002)(33656002)(229853002)(8676002)(9686003)(55016002)(81156014)(6246003)(71200400001)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0801MB1807;
 H:VI1PR0801MB1677.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 7YZGu0/rggLm+5fBgbCPoUnGwI4YbjkzrrbbjrNg9Ms5rkjolWuev1X1jNt85OaUhLdBANQLAYs018Qzxp7WhHEFkGIRUnwIPSKw52QxuyL4iCXmr3INnXKPqbfwhEbjn3bh23lvjnjIMD1h1DCZZ75Yec0tF2IITrSb1Pgm1FkuQsU3279MOobfNaJIYhqF/yY2reFBKvrgByFWugbp14iFBrnymuCHiQHnDdvCjXztZhpHzAjA9/G3joYkPw+E97OLpHwAED0/k/Qwusc5p2QnsiRzaH4HkmD4gQAePYE0/WxPFkWRUE5Er8R/57DwLF2c/vvT03FGQqcRtYao3zAJDYq1wC2creDvvcPpTkNNeTa8bFveHq8ExYLIrmK1sJ12lVfkQlZ2C7qeFEc+CHN+QdFBqANo3NZsWmueTqrroW7NICH7nKJTOJvG3XNK
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1807
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jianyong.Wu@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123; IPV:CAL; SCL:-1; CTRY:IE;
 EFV:NLI; SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(376002)(1110001)(339900001)(199004)(189003)(13464003)(316002)(74316002)(55016002)(22756006)(70206006)(70586007)(2906002)(356004)(11346002)(476003)(86362001)(446003)(7696005)(6862004)(229853002)(4326008)(9686003)(54906003)(76176011)(6246003)(305945005)(186003)(25786009)(102836004)(99286004)(47776003)(26826003)(478600001)(105606002)(7736002)(6506007)(53546011)(66066001)(26005)(33656002)(50466002)(46406003)(8746002)(8936002)(81166006)(486006)(336012)(3846002)(6116002)(23726003)(5660300002)(81156014)(97756001)(8676002)(52536014)(76130400001)(14454004)(126002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0802MB2549;
 H:64aa7808-outbound-1.mta.getcheckrecipient.com; FPR:; SPF:Fail; LANG:en;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; A:1; MX:1; 
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9dabf6fb-8949-47c2-550f-08d769a53dd2
NoDisclaimer: True
X-Forefront-PRVS: 02229A4115
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMdhqHb/V+ZWk9FiDJAJ0BJCUW5fkpqAW0dTgfOXputMl6eWuFLCIZPQPU95xNm666uYYNWqWIJzf0RCFA+rxudQN+cgvwEOCCl9pFuUG/wbLzshNGieObAdpLfKKC/X+5nwp9FPNmmzyhAQqr4UtmWPTVahLRyM8Ca3xWEdcyfc97Qapcq0oIpZSCLDUzd/WNcOn8/mxuzoclWGcGxiWPC9w/nsAdNj9Rj1i/0QcEOCZAAmBnU1lh8ctECYvQr2OsvAeR/Em84JNRRByK6B0C0dwADwj3pKCpXOYZ45SdV7yeZB9sloh8dOzU73xW6DKz7bnjhUM3Gr3Z5jMPu/xKBPsLHZj7Kofp5NvuEbw3oCCEPCRObxlC9lHrLC7akKa86iMuCM5RDksuedXe+LeAQzbrJ5phh61jsojT7WZCRKzm/+a4B9YGZC40sRwN3b
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 08:24:41.4969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a68c049-91f1-45d6-587e-08d769a54348
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2549
Cc: "Justin He \(Arm Technology China\)" <Justin.He@arm.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "maz@kernel.org" <maz@kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "yangbo.lu@nxp.com" <yangbo.lu@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
 "john.stultz@linaro.org" <john.stultz@linaro.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, nd <nd@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi tglx,

> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, November 14, 2019 10:19 PM
> To: Jianyong Wu (Arm Technology China) <Jianyong.Wu@arm.com>
> Cc: netdev@vger.kernel.org; yangbo.lu@nxp.com; john.stultz@linaro.org;
> pbonzini@redhat.com; sean.j.christopherson@intel.com; maz@kernel.org;
> richardcochran@gmail.com; Mark Rutland <Mark.Rutland@arm.com>;
> will@kernel.org; Suzuki Poulose <Suzuki.Poulose@arm.com>; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> kvmarm@lists.cs.columbia.edu; kvm@vger.kernel.org; Steve Capper
> <Steve.Capper@arm.com>; Kaly Xin (Arm Technology China)
> <Kaly.Xin@arm.com>; Justin He (Arm Technology China)
> <Justin.He@arm.com>; nd <nd@arm.com>
> Subject: Re: [RFC PATCH v7 4/7] time: Add mechanism to recognize
> clocksource in time_get_snapshot
> 
> On Thu, 14 Nov 2019, Jianyong Wu wrote:
> > From: Thomas Gleixner <tglx@linutronix.de> In some scenario like
> > return device time to ptp_kvm guest, we need identify the current
> > clocksource outside core time code.
> > A mechanism added to recognize the current clocksource by export
> > clocksource id in time_get_snapshot.
> 
> Can you please replace that with the following:
> 
>  System time snapshots are not conveying information about the current
> clocksource which was used, but callers like the PTP KVM guest
> implementation have the requirement to evaluate the clocksource type to
> select the appropriate mechanism.
> 
>  Introduce a clocksource id field in struct clocksource which is by default  set
> to CSID_GENERIC (0). Clocksource implementations can set that field to  a
> value which allows to identify the clocksource.
> 
>  Store the clocksource id of the current clocksource in the
> system_time_snapshot so callers can evaluate which clocksource was used
> to  take the snapshot and act accordingly.
> 

Ok, really better.

> > diff --git a/include/linux/clocksource_ids.h
> > b/include/linux/clocksource_ids.h new file mode 100644 index
> > 000000000000..93bec8426c44
> > --- /dev/null
> > +++ b/include/linux/clocksource_ids.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */ #ifndef
> > +_LINUX_CLOCKSOURCE_IDS_H #define _LINUX_CLOCKSOURCE_IDS_H
> > +
> > +/* Enum to give clocksources a unique identifier */ enum
> > +clocksource_ids {
> > +	CSID_GENERIC		= 0,
> > +	CSID_ARM_ARCH_COUNTER,
> 
> This should only add the infrastructure with just CSID_GENERIC in place.
> 
> The ARM_ARCH variant needs to come in a seperate patch which adds the
> enum and uses it in the corresponding driver. Seperate means a patch doing
> only that and nothing else, i.e. not hidden in some other patch which actually
> makes use of it.
> 

Yeah, this patch should be arch independent and "CSID_ARM_ARCH_COUNTER" should be in an
Separate patch.

Thanks
Jianyong

Thanks
> Thanks,
> 
> 	tglx
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
