Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED82C03A5
	for <lists+kvmarm@lfdr.de>; Fri, 27 Sep 2019 12:43:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ABD204A76F;
	Fri, 27 Sep 2019 06:43:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.908
X-Spam-Level: 
X-Spam-Status: No, score=0.908 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@armh.onmicrosoft.com
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@armh.onmicrosoft.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vsqkEtr7mNzc; Fri, 27 Sep 2019 06:43:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EB7AC4A72D;
	Fri, 27 Sep 2019 06:43:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0ED1F4A701
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Sep 2019 06:36:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C79zAPAyjdk7 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 Sep 2019 06:36:11 -0400 (EDT)
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40062.outbound.protection.outlook.com [40.107.4.62])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6BA8B4A6FE
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Sep 2019 06:36:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHcdoF54D9BiMQlnQNMi1xxISdD/Thbn1ourleAWJew=;
 b=sV0OEhG8vrsjgGsjsJPHnSKXzwa1+crNB49fETcWL++zJcFeCDvbOIy7CVHX7YyKlvhG7HnZt9czAxz0yn1nUqAcLf21SJQkuqtyA+rnLATsnDbJk6jZaL9NDDJWthvV+6lgYYSUK5FsDl7vlKObqNT8Ez0QKQBQHynyaY7eP1U=
Received: from VI1PR08CA0106.eurprd08.prod.outlook.com (2603:10a6:800:d3::32)
 by DB7PR08MB3753.eurprd08.prod.outlook.com (2603:10a6:10:7e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17; Fri, 27 Sep
 2019 10:36:09 +0000
Received: from AM5EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by VI1PR08CA0106.outlook.office365.com
 (2603:10a6:800:d3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.20 via Frontend
 Transport; Fri, 27 Sep 2019 10:36:09 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.cs.columbia.edu; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.cs.columbia.edu; dmarc=none
 action=none header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT053.mail.protection.outlook.com (10.152.16.210) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 27 Sep 2019 10:36:07 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33");
 Fri, 27 Sep 2019 10:35:58 +0000
X-CR-MTA-TID: 64aa7808
Received: from 5f7cc7921a1a.4 (ip-172-16-0-2.eu-west-1.compute.internal
 [104.47.13.56]) by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 F370A33A-78CE-4A24-959C-49399167C8B1.1; 
 Fri, 27 Sep 2019 10:35:53 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56])
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5f7cc7921a1a.4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
 Fri, 27 Sep 2019 10:35:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJzXmHsrAm1axVKLEUhbQkogIGyN+SZk/8RynuaWrw9qqg/Vyxn36cwXpyMXYzejQJK1qyDOZecol6lU6mgvS6qXPfYRb4HqgCm/fbjbGmpbEsyxtP6oUhRXjnGfa4PRzV/A7+GeGvEAUtyZfjDNUt7e2Fc5hylRZnAWYKyJZxquEmTJ11cq2/cXnPrHsC3B3nhrD32WeT0H7tzE82Z0UDGvY+s1rIwhxxNVdtQ9ENBFFd5TC6maF+NyiId1kkMOKmly8zDB+jU7OsP8EM/0kciFQFFopzEZRCC9MMERwn+CMmeVuvYvU7fmtDIrtrM/U6NflzCOaN1bDunrNMPQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHcdoF54D9BiMQlnQNMi1xxISdD/Thbn1ourleAWJew=;
 b=msG8Sq0EBVvQN2AbpxWcKGrielObWbzAAiXCAiJzwAIwl2wJ2PmUeoDRZLyRZ8E10coBND+ZB/L4BvYBU6OrJYMjCuBbJXwT9EQ1D6MNlzFW0jVU+ab7tsYjD9vA0oLBNeb3uftFceT3teLghAXArn6RebDEZ1MDX9auzyRL/hLoPRTi3DGvFnupNywalm1sNA33fdDl1tQ+gGqrSmfnfFl8yt/EMXTvxjMkB2rGS/ZaBZutWkp3y5W+wX8V7Mh6qdbK2ZwPVy67dWQMeVx6CG/j19lZzJNpvwmx3zfP1wQ0jPmdBJ1ihVXLaJhy/H3kecMMIOAMvj74fSZMR4Ym7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHcdoF54D9BiMQlnQNMi1xxISdD/Thbn1ourleAWJew=;
 b=sV0OEhG8vrsjgGsjsJPHnSKXzwa1+crNB49fETcWL++zJcFeCDvbOIy7CVHX7YyKlvhG7HnZt9czAxz0yn1nUqAcLf21SJQkuqtyA+rnLATsnDbJk6jZaL9NDDJWthvV+6lgYYSUK5FsDl7vlKObqNT8Ez0QKQBQHynyaY7eP1U=
Received: from HE1PR0801MB1676.eurprd08.prod.outlook.com (10.168.146.150) by
 HE1PR0801MB1996.eurprd08.prod.outlook.com (10.168.97.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 27 Sep 2019 10:35:50 +0000
Received: from HE1PR0801MB1676.eurprd08.prod.outlook.com
 ([fe80::4d35:2b8f:1786:84cd]) by HE1PR0801MB1676.eurprd08.prod.outlook.com
 ([fe80::4d35:2b8f:1786:84cd%3]) with mapi id 15.20.2284.028; Fri, 27 Sep 2019
 10:35:50 +0000
From: "Jianyong Wu (Arm Technology China)" <Jianyong.Wu@arm.com>
To: Suzuki Poulose <Suzuki.Poulose@arm.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "yangbo.lu@nxp.com" <yangbo.lu@nxp.com>,
 "john.stultz@linaro.org" <john.stultz@linaro.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
 "maz@kernel.org" <maz@kernel.org>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, Mark Rutland <Mark.Rutland@arm.com>, Will Deacon
 <Will.Deacon@arm.com>
Subject: RE: [RFC PATCH v4 2/5] ptp: Reorganize ptp_kvm modules to make it
 arch-independent.
Thread-Topic: [RFC PATCH v4 2/5] ptp: Reorganize ptp_kvm modules to make it
 arch-independent.
Thread-Index: AQHVdF+Ft3UnKFEitUOtlQstSNDglqc/UlgAgAADTsA=
Date: Fri, 27 Sep 2019 10:35:50 +0000
Message-ID: <HE1PR0801MB1676C739058C44645D726C72F4810@HE1PR0801MB1676.eurprd08.prod.outlook.com>
References: <20190926114212.5322-1-jianyong.wu@arm.com>
 <20190926114212.5322-3-jianyong.wu@arm.com>
 <47ceb25c-c9ff-e284-43bf-6cac7e128a98@arm.com>
In-Reply-To: <47ceb25c-c9ff-e284-43bf-6cac7e128a98@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 6d537bca-1c2d-4e6a-bfe5-12f285ab8d8b.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Jianyong.Wu@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: bba7a90f-5a26-488c-4d67-08d743368181
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1996:|HE1PR0801MB1996:|DB7PR08MB3753:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB375392D3C462A1E42DA7113CF4810@DB7PR08MB3753.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4714;OLM:4714;
x-forefront-prvs: 0173C6D4D5
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(13464003)(5660300002)(52536014)(71190400001)(256004)(71200400001)(478600001)(11346002)(476003)(8676002)(229853002)(81166006)(81156014)(2501003)(305945005)(99286004)(74316002)(7736002)(8936002)(7416002)(446003)(66066001)(76116006)(14454004)(7696005)(26005)(102836004)(6506007)(66446008)(186003)(25786009)(53546011)(486006)(66556008)(64756008)(66946007)(66476007)(76176011)(55236004)(86362001)(2201001)(6246003)(55016002)(6636002)(4326008)(9686003)(54906003)(110136005)(33656002)(316002)(6436002)(2906002)(6116002)(3846002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0801MB1996;
 H:HE1PR0801MB1676.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fUfMtMH09SaJHMMSXV4YPYqgl7wdRx1SbUvLJ9N0u/Oq9j4Ylh4hiZ6+keMyN/Fao4rNMqnrFEq1z00mxliidyc/o3NnCp4xrNPIMYdQfDSUEnq4/9JXTiBD4J5VVnZQCDAC+2kAsDeIBKIJlRjkMLGb4EA0aVjMDDuvdXv7YoCbFBNH2gnXux4pNHVEcWTyZIKPqV59AKWxvGO0XYG0YDVxh7jtIgQqlbolJQ+kNjuO9lDUjogZX1lbrhy2GayZ560h9LfW7MpvB9uA6ZYNLJrjAbTKNIi1WvTqJnjGvJP0CwsLtgeENU6wyrLy/IvxjQO1Pyv0zTmyR8DuAmZLj1freMWJNYb5sJC85zDlhpNOHE2gJO9lgaRBW1erWiJhSGzt0BmVUU2uN/6UM7kYrHTwVPm3ih0vomV80rmCrHU=
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1996
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jianyong.Wu@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123; IPV:CAL; SCL:-1; CTRY:IE;
 EFV:NLI; SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(13464003)(189003)(199004)(110136005)(54906003)(6506007)(33656002)(2201001)(336012)(74316002)(86362001)(11346002)(486006)(99286004)(63350400001)(436003)(47776003)(126002)(446003)(186003)(6116002)(2486003)(23676004)(66066001)(2906002)(26005)(76176011)(102836004)(305945005)(7736002)(52536014)(476003)(14454004)(25786009)(50466002)(5660300002)(36906005)(478600001)(316002)(76130400001)(70586007)(70206006)(8676002)(356004)(81156014)(81166006)(6636002)(3846002)(7696005)(53546011)(8936002)(9686003)(26826003)(229853002)(6246003)(4326008)(55016002)(22756006)(2501003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR08MB3753;
 H:64aa7808-outbound-1.mta.getcheckrecipient.com; FPR:; SPF:TempError; LANG:en;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; MX:1; A:1; 
X-MS-Office365-Filtering-Correlation-Id-Prvs: d3d1f84f-d3d2-4030-2a2c-08d74336773e
NoDisclaimer: True
X-Forefront-PRVS: 0173C6D4D5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uytCvHfEp0BpMMZY/irRrQQ6In5Wim1Wubf1rb0XMAqNo/ScM+GtRpjl/On7GVU9wioJZ4SYF5e4WCAvYiMXIStfUdJxJwZg5TEpTaWqoOHf3sqG9Nejj5hG2GPVC0H6CORIidwTuW+N374sobr0DuTDIRSvm1zuCiBx6X1Y27i8wSus5FM435m6oOtdO+nhBJbTs/tFbvVfQ14J4jyyPw/HuJoR6mqZH5SxdERftW4MZM2dRy3phOxTJ2k5ucZdcbMueAy98bBWnCHkfH6wkxbCoTErM2Zt5R0xAMg9nYjippwQs3pemDFHbiuWnIvCmZHUXM2EKjqdzeAr78s3gTfeUK2r3Jk4Ac9NX8q79wYkBVng2/Motd8CrMV77NevZvjGr58R3nQDpBZ5zg9ve+9ATuGm/y15NmtG415+w24=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2019 10:36:07.5543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bba7a90f-5a26-488c-4d67-08d743368181
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3753
X-Mailman-Approved-At: Fri, 27 Sep 2019 06:43:42 -0400
Cc: "Justin He \(Arm Technology China\)" <Justin.He@arm.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nd <nd@arm.com>,
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

Hi Suzuki,

> -----Original Message-----
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> Sent: Friday, September 27, 2019 6:23 PM
> To: Jianyong Wu (Arm Technology China) <Jianyong.Wu@arm.com>;
> netdev@vger.kernel.org; yangbo.lu@nxp.com; john.stultz@linaro.org;
> tglx@linutronix.de; pbonzini@redhat.com; sean.j.christopherson@intel.com;
> maz@kernel.org; richardcochran@gmail.com; Mark Rutland
> <Mark.Rutland@arm.com>; Will Deacon <Will.Deacon@arm.com>
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> kvmarm@lists.cs.columbia.edu; kvm@vger.kernel.org; Steve Capper
> <Steve.Capper@arm.com>; Kaly Xin (Arm Technology China)
> <Kaly.Xin@arm.com>; Justin He (Arm Technology China)
> <Justin.He@arm.com>; nd <nd@arm.com>
> Subject: Re: [RFC PATCH v4 2/5] ptp: Reorganize ptp_kvm modules to make it
> arch-independent.
> 
> 
> 
> On 26/09/2019 12:42, Jianyong Wu wrote:
> > Currently, ptp_kvm modules implementation is only for x86 which
> > includs large part of arch-specific code.  This patch move all of
> > those code into new arch related file in the same directory.
> >
> > Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> 
> ...
> 
> > +int kvm_arch_ptp_get_clock_fn(unsigned long *cycle, struct timespec64
> *tspec,
> > +			      struct clocksource **cs)
> 
> 
> > diff --git a/include/asm-generic/ptp_kvm.h
> > b/include/asm-generic/ptp_kvm.h new file mode 100644 index
> > 000000000000..208e842bfa64
> > --- /dev/null
> > +++ b/include/asm-generic/ptp_kvm.h
> 
> > +int kvm_arch_ptp_get_clock_fn(long *cycle,
> > +		struct timespec64 *tspec, void *cs);
> >
> 
> Conflicting types for kvm_arch_ptp_get_clock_fn() ?
> 
Yeah, need fix.

Thanks
Jianyong Wu

> Suzuki
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
