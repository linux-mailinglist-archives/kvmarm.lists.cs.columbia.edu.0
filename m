Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7F695138F17
	for <lists+kvmarm@lfdr.de>; Mon, 13 Jan 2020 11:30:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 77E5C4AEF8;
	Mon, 13 Jan 2020 05:30:37 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	UNPARSEABLE_RELAY=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@armh.onmicrosoft.com
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@armh.onmicrosoft.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rBCKV3oBF2j2; Mon, 13 Jan 2020 05:30:37 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B3E734AEFD;
	Mon, 13 Jan 2020 05:30:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A3344AEC9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Jan 2020 05:30:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jJGWrmMw1PXJ for <kvmarm@lists.cs.columbia.edu>;
 Mon, 13 Jan 2020 05:30:24 -0500 (EST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80052.outbound.protection.outlook.com [40.107.8.52])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 817914AECA
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Jan 2020 05:30:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0xmuY5jgnprKd5FS468llO7cLxmixChk8r2J3IVv1U=;
 b=0UxuehJJPXPBzo93T9w+LI4dBfuXSOGofaeOtFBbYcXrgoX+6x/LJFRB7R9aUpWApaHp0HGub0XErdUZ+u2lNjUi8haN/ZNn5cqWIdKeAXXx9y0+mu9DCeTEZmhTdBy674DMUYW6LTbPsi8+7xSBpReiDPH8R5CR9YzRHUJzLf0=
Received: from VI1PR08CA0098.eurprd08.prod.outlook.com (2603:10a6:800:d3::24)
 by AM6PR08MB5064.eurprd08.prod.outlook.com (2603:10a6:20b:e6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13; Mon, 13 Jan
 2020 10:30:20 +0000
Received: from AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by VI1PR08CA0098.outlook.office365.com
 (2603:10a6:800:d3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Mon, 13 Jan 2020 10:30:20 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.cs.columbia.edu; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.cs.columbia.edu;
 dmarc=bestguesspass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT061.mail.protection.outlook.com (10.152.16.247) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 13 Jan 2020 10:30:19 +0000
Received: ("Tessian outbound 1da651c29646:v40");
 Mon, 13 Jan 2020 10:30:19 +0000
X-CR-MTA-TID: 64aa7808
Received: from b5f5d1130c4c.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 1BF7D65A-0CA4-4669-B57E-27485FDFBAA1.1; 
 Mon, 13 Jan 2020 10:30:14 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b5f5d1130c4c.2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Mon, 13 Jan 2020 10:30:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7WSnlkzINWY411QiuIUsZGP8kZBHxok1gYEU5lOW3hw4g7Jq4GkoNofh39lO5TTYx/Z5jNxpgA8dThEB+nMYvgXQO6EgbGSsADv0oBYBVFOahgmYg3KcX/PpV08zUFfNMkd3V+a9tMULgDNbLyvQAUaKCe2RLr1v/aPPThBqnsm5D4yzXduL0eKEN1IHkyg7qGcMjDCgn1Oiym+KwA4wSRHmH4gma2a1kO2omiey0dHd9rpkXsWRXnciLu1ozPzdqenjR8rxCRpk0SnH+MEMAt1AFKKeVnmtJz+EX9DTINoNZbK4W7dC1SMl4+fD7HMlfy4MlQdFXcmLbOd3ywV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0xmuY5jgnprKd5FS468llO7cLxmixChk8r2J3IVv1U=;
 b=KHg/BzswW9NWm0jT82jaFCzmy0ORid54hS9LsN5rsJKspcViHY8sj55pOis/KihjTAAnwigMqqITBb0u9lnzP1AYKm2bh5nc812/NZavvcFpPI+lk3XZPPIEanz8K4DWzD46WOO1MRyXZKo4tJDC8qdwOsHaTnGVOu5ODhhS18JopvAdvZ3yAX2kAZfXUX7TVA3pZ6/yVbqXZxz1jWPoJyYph2VzQMtcTrIDg431hTqpzEkEE1oP9/vYxn5Ja2F8z0p/Uwur6J33JxIhT79ARe7F17Wz8QyKlNUGUjR77P+LybdJ7yqGTGku2rFosFrNzagEiMbTSYAyT+oGrT5GkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0xmuY5jgnprKd5FS468llO7cLxmixChk8r2J3IVv1U=;
 b=0UxuehJJPXPBzo93T9w+LI4dBfuXSOGofaeOtFBbYcXrgoX+6x/LJFRB7R9aUpWApaHp0HGub0XErdUZ+u2lNjUi8haN/ZNn5cqWIdKeAXXx9y0+mu9DCeTEZmhTdBy674DMUYW6LTbPsi8+7xSBpReiDPH8R5CR9YzRHUJzLf0=
Received: from HE1PR0801MB1676.eurprd08.prod.outlook.com (10.168.146.150) by
 HE1PR0801MB1803.eurprd08.prod.outlook.com (10.168.148.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 10:30:11 +0000
Received: from HE1PR0801MB1676.eurprd08.prod.outlook.com
 ([fe80::49c0:e8df:b9be:724f]) by HE1PR0801MB1676.eurprd08.prod.outlook.com
 ([fe80::49c0:e8df:b9be:724f%8]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 10:30:11 +0000
From: Jianyong Wu <Jianyong.Wu@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: RE: [RFC PATCH v9 6/8] psci: Add hvc call service for ptp_kvm.
Thread-Topic: [RFC PATCH v9 6/8] psci: Add hvc call service for ptp_kvm.
Thread-Index: AQHVrwuxR+1ZEaCriEa+CGCL3lP4K6ffGBkAgALhg9CAAEMegIABkMMAgAAdn4CABKu08A==
Date: Mon, 13 Jan 2020 10:30:10 +0000
Message-ID: <HE1PR0801MB167693BFB769ACEEA8A6B007F4350@HE1PR0801MB1676.eurprd08.prod.outlook.com>
References: <20191210034026.45229-1-jianyong.wu@arm.com>
 <20191210034026.45229-7-jianyong.wu@arm.com>
 <7383dc06897bba253f174cd21a19b5c0@kernel.org>
 <HE1PR0801MB1676AB738138AB24E2158AD4F4390@HE1PR0801MB1676.eurprd08.prod.outlook.com>
 <099a26ffef5d554b88a5e33d7f2a6e3a@kernel.org>
 <HE1PR0801MB16765B507D9B5A1A7827078BF4380@HE1PR0801MB1676.eurprd08.prod.outlook.com>
 <ca80d88f5e00937fca7ee80be8f5c962@kernel.org>
In-Reply-To: <ca80d88f5e00937fca7ee80be8f5c962@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: bc0b5312-7e18-4b28-ab46-9595b2dd3baf.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Jianyong.Wu@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fbf322de-788f-44a8-b039-08d7981396cc
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1803:|HE1PR0801MB1803:|AM6PR08MB5064:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5064E9E3570FBAFB5D33015AF4350@AM6PR08MB5064.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 028166BF91
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(2906002)(4001150100001)(71200400001)(6506007)(53546011)(55236004)(26005)(186003)(7696005)(7416002)(316002)(54906003)(8936002)(52536014)(8676002)(81166006)(5660300002)(81156014)(9686003)(76116006)(6916009)(66946007)(66556008)(64756008)(66446008)(66476007)(33656002)(4326008)(86362001)(55016002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0801MB1803;
 H:HE1PR0801MB1676.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: wi0aWHtQ7DZpbGp2BWNVFTUPe/ayMXn2cd0S/I7Sdn4c4GEpv/hAZQ/DH81Z9IeBlhkQEELSm58UtJaIY1eG5HyABpV1DtQyLq8qxZmw78t/yBNb32T/EUm3FhDYmQxAnApA6npoivUnrYHdUHJ+d22pQwgtqkWBUJJqo/zdkcsYUx+MfJ/XY+owqiE/CuoZPpTrZQP+7Fhh4Uvc0MR0ne+ZTUf1FuTJ1Xu9LAazjf+pX/R8lE01ju/zmseRor9fQPZkfke/l4iU8ngBJ0q/MPKcS75M4BoXLADWvjJGe1KrXjqArVVj5mU+xwR5LKMLiIbxlPT8eOOGj/5/KNpBbcUxeSwTIGzJWTe7fkmAwiq6U/KbKgxUodywhdJ6NCD3J+haFs5BbYNkn0Qu5Rdd93ys1qBx9mILS5NmbuIVxI8Kav+UePN677lqz5s+KTA3
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1803
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jianyong.Wu@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123; IPV:CAL; SCL:-1; CTRY:IE;
 EFV:NLI; SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(336012)(356004)(2906002)(26826003)(33656002)(4326008)(7696005)(4001150100001)(55016002)(478600001)(8676002)(53546011)(6506007)(6862004)(54906003)(81166006)(5660300002)(316002)(9686003)(81156014)(26005)(86362001)(36906005)(70206006)(8936002)(70586007)(52536014)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR08MB5064;
 H:64aa7808-outbound-1.mta.getcheckrecipient.com; FPR:; SPF:Pass; LANG:en;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; MX:1; A:1; 
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1c12a954-7519-4c88-2ce3-08d7981391ad
X-Forefront-PRVS: 028166BF91
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xr8JCdOg84jysM/XKhhp7ZzGJEoqwK9Ld5box9S7TC4F/oKbfofGoaygya+fOolGLFuiQIeYh/SRTQK5X4FtHBGDhrkqxtfHlj15L+jahTS0iwzRfwNA3eOGLmZP2VGnDobJ2xsGPks71Y1yghyDRzhhmC6LqpZRMlUamJCU1HPF3W8cW/hcR11SIjrWlyh8XZ96vYCXvDu2Y3hEKMniQ0m3Pv7TeN7UzbP69xa22gfpZDVxtGpoj7A6djlS8/VqQ8CmgKeettOnzuGkdWiqU/JQx2rfOeF2Ai4mqtHrliPwxsgM7ZO7GgU1do5Y6LvSCOw883WWWCFQ3rqtf+XokJX0o8R3WSpv3Ky/7y1BANmAvHnG/ZRgtLN3CQv5qnp6acQwLoeXo/HjK3Bi0ljuyxsUPlorBsTI/76n0/LMPHgzHXYr6NTot8+5j0dYR3oM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 10:30:19.6991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf322de-788f-44a8-b039-08d7981396cc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5064
Cc: Justin He <Justin.He@arm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
 Steven Price <Steven.Price@arm.com>,
 "john.stultz@linaro.org" <john.stultz@linaro.org>,
 "yangbo.lu@nxp.com" <yangbo.lu@nxp.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, nd <nd@arm.com>,
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

Hi Marc,

> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Friday, January 10, 2020 6:56 PM
> To: Jianyong Wu <Jianyong.Wu@arm.com>
> Cc: netdev@vger.kernel.org; yangbo.lu@nxp.com; john.stultz@linaro.org;
> tglx@linutronix.de; pbonzini@redhat.com; sean.j.christopherson@intel.com;
> richardcochran@gmail.com; Mark Rutland <Mark.Rutland@arm.com>;
> will@kernel.org; Suzuki Poulose <Suzuki.Poulose@arm.com>; Steven Price
> <Steven.Price@arm.com>; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> kvm@vger.kernel.org; Steve Capper <Steve.Capper@arm.com>; Kaly Xin
> <Kaly.Xin@arm.com>; Justin He <Justin.He@arm.com>; nd <nd@arm.com>
> Subject: Re: [RFC PATCH v9 6/8] psci: Add hvc call service for ptp_kvm.
> 
> On 2020-01-10 09:51, Jianyong Wu wrote:
> > Hi Marc,
> >
> >> -----Original Message-----
> >> From: Marc Zyngier <maz@kernel.org>
> >> Sent: Thursday, January 9, 2020 5:16 PM
> >> To: Jianyong Wu <Jianyong.Wu@arm.com>
> >> Cc: netdev@vger.kernel.org; yangbo.lu@nxp.com;
> >> john.stultz@linaro.org; tglx@linutronix.de; pbonzini@redhat.com;
> >> sean.j.christopherson@intel.com; richardcochran@gmail.com; Mark
> >> Rutland <Mark.Rutland@arm.com>; will@kernel.org; Suzuki Poulose
> >> <Suzuki.Poulose@arm.com>; Steven Price <Steven.Price@arm.com>;
> >> linux-kernel@vger.kernel.org; linux-arm- kernel@lists.infradead.org;
> >> kvmarm@lists.cs.columbia.edu; kvm@vger.kernel.org; Steve Capper
> >> <Steve.Capper@arm.com>; Kaly Xin <Kaly.Xin@arm.com>; Justin He
> >> <Justin.He@arm.com>; nd <nd@arm.com>
> >> Subject: Re: [RFC PATCH v9 6/8] psci: Add hvc call service for
> >> ptp_kvm.
> >>
> >> On 2020-01-09 05:45, Jianyong Wu wrote:
> >> > Hi Marc,
> >> >
> >> >> -----Original Message-----
> >> >> From: Marc Zyngier <maz@kernel.org>
> >> >> Sent: Tuesday, January 7, 2020 5:16 PM
> >> >> To: Jianyong Wu <Jianyong.Wu@arm.com>
> >> >> Cc: netdev@vger.kernel.org; yangbo.lu@nxp.com;
> >> >> john.stultz@linaro.org; tglx@linutronix.de; pbonzini@redhat.com;
> >> >> sean.j.christopherson@intel.com; richardcochran@gmail.com; Mark
> >> >> Rutland <Mark.Rutland@arm.com>; will@kernel.org; Suzuki Poulose
> >> >> <Suzuki.Poulose@arm.com>; Steven Price <Steven.Price@arm.com>;
> >> >> linux-kernel@vger.kernel.org; linux-arm-
> >> >> kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> >> >> kvm@vger.kernel.org; Steve Capper <Steve.Capper@arm.com>; Kaly
> Xin
> >> >> <Kaly.Xin@arm.com>; Justin He <Justin.He@arm.com>; nd
> <nd@arm.com>
> >> >> Subject: Re: [RFC PATCH v9 6/8] psci: Add hvc call service for
> >> >> ptp_kvm.
> >> >>
> >> >> On 2019-12-10 03:40, Jianyong Wu wrote:
> >> >> > ptp_kvm modules will call hvc to get this service.
> >> >> > The service offers real time and counter cycle of host for guest.
> >> >> >
> >> >> > Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> >> >> > ---
> >> >> >  include/linux/arm-smccc.h | 12 ++++++++++++
> >> >> >  virt/kvm/arm/psci.c       | 22 ++++++++++++++++++++++
> >> >> >  2 files changed, 34 insertions(+)
> >> >> >
> >> >> > diff --git a/include/linux/arm-smccc.h
> >> >> > b/include/linux/arm-smccc.h index 6f82c87308ed..aafb6bac167d
> >> >> > 100644
> >> >> > --- a/include/linux/arm-smccc.h
> >> >> > +++ b/include/linux/arm-smccc.h
> >> >> > @@ -94,6 +94,7 @@
> >> >> >
> >> >> >  /* KVM "vendor specific" services */
> >> >> >  #define ARM_SMCCC_KVM_FUNC_FEATURES		0
> >> >> > +#define ARM_SMCCC_KVM_PTP			1
> >> >> >  #define ARM_SMCCC_KVM_FUNC_FEATURES_2		127
> >> >> >  #define ARM_SMCCC_KVM_NUM_FUNCS			128
> >> >> >
> >> >> > @@ -103,6 +104,17 @@
> >> >> >  			   ARM_SMCCC_OWNER_VENDOR_HYP,
> >> >> 		\
> >> >> >  			   ARM_SMCCC_KVM_FUNC_FEATURES)
> >> >> >
> >> >> > +/*
> >> >> > + * This ID used for virtual ptp kvm clock and it will pass
> >> >> > +second
> >> >> > value
> >> >> > + * and nanosecond value of host real time and system counter by
> >> >> > +vcpu
> >> >> > + * register to guest.
> >> >> > + */
> >> >> > +#define ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID
> >> >> 		\
> >> >> > +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,
> >> >> 		\
> >> >> > +			   ARM_SMCCC_SMC_32,
> >> >> 	\
> >> >> > +			   ARM_SMCCC_OWNER_VENDOR_HYP,
> >> >> 		\
> >> >> > +			   ARM_SMCCC_KVM_PTP)
> >> >> > +
> >> >>
> >> >> All of this depends on patches that have never need posted to any
> >> >> ML, and just linger in Will's tree. You need to pick them up and
> >> >> post them as part of this series so that they can at least be reviewed.
> >> >>
> >> > Ok, I will add them next version.
> >> >
> >> >> >  #ifndef __ASSEMBLY__
> >> >> >
> >> >> >  #include <linux/linkage.h>
> >> >> > diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c index
> >> >> > 0debf49bf259..682d892d6717 100644
> >> >> > --- a/virt/kvm/arm/psci.c
> >> >> > +++ b/virt/kvm/arm/psci.c
> >> >> > @@ -9,6 +9,7 @@
> >> >> >  #include <linux/kvm_host.h>
> >> >> >  #include <linux/uaccess.h>
> >> >> >  #include <linux/wait.h>
> >> >> > +#include <linux/clocksource_ids.h>
> >> >> >
> >> >> >  #include <asm/cputype.h>
> >> >> >  #include <asm/kvm_emulate.h>
> >> >> > @@ -389,6 +390,8 @@ static int kvm_psci_call(struct kvm_vcpu
> >> >> > *vcpu)
> >> >> >
> >> >> >  int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)  {
> >> >> > +	struct system_time_snapshot systime_snapshot;
> >> >> > +	u64 cycles;
> >> >> >  	u32 func_id = smccc_get_function(vcpu);
> >> >> >  	u32 val[4] = {};
> >> >> >  	u32 option;
> >> >> > @@ -431,6 +434,25 @@ int kvm_hvc_call_handler(struct kvm_vcpu
> >> *vcpu)
> >> >> >  	case
> ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
> >> >> >  		val[0] = BIT(ARM_SMCCC_KVM_FUNC_FEATURES);
> >> >> >  		break;
> >> >> > +	/*
> >> >> > +	 * This will used for virtual ptp kvm clock. three
> >> >> > +	 * values will be passed back.
> >> >> > +	 * reg0 stores high 32-bit host ktime;
> >> >> > +	 * reg1 stores low 32-bit host ktime;
> >> >> > +	 * reg2 stores high 32-bit difference of host cycles and cntvoff;
> >> >> > +	 * reg3 stores low 32-bit difference of host cycles and cntvoff.
> >> >>
> >> >> That's either two or four values, and not three as you claim above.
> >> >>
> >> > Sorry, I'm not sure what do you mean "three", the registers here is
> >> > 4 from reg0 to reg3.
> >>
> >> Please read the comment you have written above...
> >
> > oh, I see it.
> >
> >>
> >> >> Also, I fail to understand the meaning of the host cycle vs
> >> >> cntvoff comparison.
> >> >> This is something that guest can perform on its own (it has access
> >> >> to both physical and virtual timers, and can compute cntvoff
> >> >> without intervention of the hypervisor).
> >> >>
> >> > To keep consistency and precision, clock time and counter cycle
> >> > must captured at the same time. It will perform at ktime_get_snapshot.
> >>
> >> Fair enough. It would vertainly help if you documented it. It would
> >> also help if you explained why it is so much worse to read the
> >> counter in the guest before *and* after the call, and assume that the
> >> clock time read happened right in the middle?
> >>
> > ok, I will give explain in comments.
> >
> >> That aside, what you are returning is something that *looks* like the
> >> virtual counter. What if the guest is using the physical counter,
> >> which is likely to be the case with nested virt? Do you expect the
> >> guest to always use the virtual counter? This isn't going to fly.
> >
> > To be honest, I have little knowledge of nested virtualization for arm
> > and I'm confused with that guest'guest will use physical counter.
> 
> Not the guest's guest (L2), but L1. Just look at what counter the KVM host
> uses: that's the physical counter. Now imagine you run that host as a guest,
> no other change.
> 
Ok,

> > IMO, ptp_kvm will call hvc to trap to its hypervisor adjacent to it.
> > So guest'guest will trap to hypervisor in guest and will get guest's
> > counter cycle then calculate guest'guest's counter cycle by something
> > like offset to sync time with it. So only if the guest's hypervisor
> > can calculate the guest'guest's counter value, can ptp_kvm works.
> 
> Sure, but that's not the problem we're trying to solve. The issue is that of the
> reference counter value you're including in the hypercall response.
> It needs to be a value that makes sense to the guest, and so far you're
> assuming virtual.
>
Get it.
 
> NV breaks that assumtion, because the guest hypervisor is using the physical
> counter. Also, let's not forget that the hypercall isn't Linux specific.
> I can write my own non-Linux guest and still use this hypercall. Nothing in
> there says that I can't use the physical counter if I want to.
> 
> So somehow, you need to convey the the hypervisor the notion of *which*
> counter the guest uses.
> 
> Does it make sense? Or am I missing something?
>
I know what you say. Let me try to solve this problem.
	Step 0, summary out all the conditions we should process, which will sever as branch condition.(now only normal virt and nested virt, I think) 
	Step 1, figure out the set of reference counter value used by guest in all condition.
	Step 2, determine which reference counter value will be used by guest in a certain condition in hypercall.
In step 1, can we give the set only 2 elements that one is physical counter the other is virtual counter?
For step 2, I have no idea for that now. can you give me some hint about it?

Thanks
Jianyong 
 
> Thanks,
> 
>          M.
> --
> Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
