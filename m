Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 569FF1352E8
	for <lists+kvmarm@lfdr.de>; Thu,  9 Jan 2020 07:00:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E05EF4B2B2;
	Thu,  9 Jan 2020 01:00:05 -0500 (EST)
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
	with ESMTP id CQpf6EsHPIVj; Thu,  9 Jan 2020 01:00:05 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 353174B2A1;
	Thu,  9 Jan 2020 01:00:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1644C4B1F2
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Jan 2020 01:00:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id scTGguZ4Mczo for <kvmarm@lists.cs.columbia.edu>;
 Thu,  9 Jan 2020 00:59:58 -0500 (EST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 272B54B1D3
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Jan 2020 00:59:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laTJaVF6y+/5xZ0DLmtowkviRp4g27hZ282e9ZAKxOY=;
 b=31xUD5q6ALFRFtwXs2iuLeNAxZ8hStlZgiXtaRMP2IzpxPALl7Cn0Fn9jdk1fNSk4XlswpgpZEdzsdaCIvydgHUAAqK2kNWu7fhnWAXw4sDdYtvdtX7+UJAtSVFk8oY3adg3BkLVVIsLAbjd5sovcwjMjc0MT8bvtVgP2oq1lPI=
Received: from VI1PR08CA0156.eurprd08.prod.outlook.com (2603:10a6:800:d5::34)
 by AM6PR08MB4933.eurprd08.prod.outlook.com (2603:10a6:20b:e9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Thu, 9 Jan
 2020 05:59:54 +0000
Received: from VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VI1PR08CA0156.outlook.office365.com
 (2603:10a6:800:d5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Thu, 9 Jan 2020 05:59:54 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.cs.columbia.edu; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.cs.columbia.edu;
 dmarc=bestguesspass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT033.mail.protection.outlook.com (10.152.18.147) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Thu, 9 Jan 2020 05:59:53 +0000
Received: ("Tessian outbound 121a58c8f9bf:v40");
 Thu, 09 Jan 2020 05:59:53 +0000
X-CR-MTA-TID: 64aa7808
Received: from 48ecd7323ecb.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 E1FB7FD0-062B-4B65-A5B9-469657B8BD0D.1; 
 Thu, 09 Jan 2020 05:59:48 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 48ecd7323ecb.2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Thu, 09 Jan 2020 05:59:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDvt4v1JXStKieQLq7G1c2+emsgnz916VZx6Gfl9gh9kbARWzdolkwq69QwP5AtwuuXZwJ1Klwk2eqsYHQYZk0R8lmFz4uQGrgszM3vNu3Kdhw38j5LXtKsxN1092v+fXbc1phDvWAsLWDWwjtwICVAz5vRp99VNEcC/+ek6nZNaUHS0uEDtpxxDQxD9EYJm2c1Z3QyseMzA0zSGv5Alr/xExYy0Du9wuGqI9kGA1MsNbmz9vxI36atHp0OKNWjsKY+dd/OT6iSHLnHrXVy+ZOuUk9jIC3LLM0ENGWD4QB/Ndufh2KpDKHkXXzINjXIF7weetUi6tMLgh7lObmJy3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laTJaVF6y+/5xZ0DLmtowkviRp4g27hZ282e9ZAKxOY=;
 b=kc90oIS5W8Q/MciivXlZx2ly2nsbTqR4lr5jn/ItrwOj6I6fVv97fHWcTxnnef84hCfApxCq0c9ZCGWuu+yRvM03rH1n40kFvK7RHBID+5m9hs48Z9UTf0kzbIU+A0+vIn+RokEJX3pv7szYi4FE1pifox8YvW9YOa6bz9QYQ0yWgEEGgdHb47KkFtEFLd0jdONQOCxsNJMMd4K+FVnE0wJvm/R7hGiMKWpI0reC/Cf2xmvqg1px5WPP5rLXY5QLiHOGkqQNQK+A/D0CySc4LYRG/cbNaTtqBHc/RN8K5rGel5Bb/JE0Egy6HDIg3CH5rlD3VumvIuBZ9Vo4Ui2QFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laTJaVF6y+/5xZ0DLmtowkviRp4g27hZ282e9ZAKxOY=;
 b=31xUD5q6ALFRFtwXs2iuLeNAxZ8hStlZgiXtaRMP2IzpxPALl7Cn0Fn9jdk1fNSk4XlswpgpZEdzsdaCIvydgHUAAqK2kNWu7fhnWAXw4sDdYtvdtX7+UJAtSVFk8oY3adg3BkLVVIsLAbjd5sovcwjMjc0MT8bvtVgP2oq1lPI=
Received: from HE1PR0801MB1676.eurprd08.prod.outlook.com (10.168.146.150) by
 HE1PR0801MB1628.eurprd08.prod.outlook.com (10.168.144.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 05:59:44 +0000
Received: from HE1PR0801MB1676.eurprd08.prod.outlook.com
 ([fe80::49c0:e8df:b9be:724f]) by HE1PR0801MB1676.eurprd08.prod.outlook.com
 ([fe80::49c0:e8df:b9be:724f%8]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 05:59:44 +0000
From: Jianyong Wu <Jianyong.Wu@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: RE: [RFC PATCH v9 7/8] ptp: arm64: Enable ptp_kvm for arm64
Thread-Topic: [RFC PATCH v9 7/8] ptp: arm64: Enable ptp_kvm for arm64
Thread-Index: AQHVrwu1ZTEnzkrQbEOo/hXDFqaU6affG9SAgALmpVA=
Date: Thu, 9 Jan 2020 05:59:44 +0000
Message-ID: <HE1PR0801MB1676EE12CF0DB7C5BB8CC62DF4390@HE1PR0801MB1676.eurprd08.prod.outlook.com>
References: <20191210034026.45229-1-jianyong.wu@arm.com>
 <20191210034026.45229-8-jianyong.wu@arm.com>
 <ca162efb3a0de530e119f5237c006515@kernel.org>
In-Reply-To: <ca162efb3a0de530e119f5237c006515@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: a1eead21-bf0b-4aef-b9b8-7a721cd39009.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Jianyong.Wu@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7bd20f46-c8c6-40ce-6a5c-08d794c9259d
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1628:|HE1PR0801MB1628:|AM6PR08MB4933:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB493345373ED8C16B9E65B9FAF4390@AM6PR08MB4933.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 02778BF158
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(13464003)(189003)(199004)(4326008)(7696005)(6916009)(55016002)(66556008)(8676002)(71200400001)(6506007)(53546011)(478600001)(81156014)(55236004)(81166006)(2906002)(66446008)(4001150100001)(64756008)(186003)(26005)(66476007)(9686003)(86362001)(33656002)(76116006)(316002)(66946007)(52536014)(7416002)(8936002)(5660300002)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0801MB1628;
 H:HE1PR0801MB1676.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: +gLsgM72gtR8RXQvt2Mn2EXIAhXjTwlogCqj+KYmrPbcR/3Vh2wcVOnM+3qLq16WU+dtfUra+FzwetZB5ohlDLEDyIZM4IMjHJx8PWOpp+muo/UZ4lvI4KjbXHyK97TLe/1oO6eszEm9mkhXvmLqqrIVTBOQ9QCKlBEmYKIArwsvDhFdv9+BnOduTYSXliMgfkN1sJucNEbofdnFTALRt7QxvTKG/STdl8F6M3u1vkMYjLg/HVMorPrUU8zCVUz9Y+YxQtCP5lPbC/EWdHbfxhoE2HhrsXKOBxCaME2radlWG+zCvbwgQ61alMUO/BmCkJLwE9yBa38y1Dl11pWdf//D9Kz1kPHIufdNMRYErPvMWFWiKKRIPoZp9T06ocM5DbSeubaGeL6y0QGqUhkOIaxEh7D3w+rK5QaSCUyvdA2iG+Kcy+Xm25lyUREwhZAi+qzypVZ+XSqyoDe660rlCt3rBih2NKev0qsue0SBTlZtBnjR1RbpbAB/lCEmkprb
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1628
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jianyong.Wu@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123; IPV:CAL; SCL:-1; CTRY:IE;
 EFV:NLI; SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(199004)(13464003)(189003)(5660300002)(81166006)(4001150100001)(8676002)(478600001)(52536014)(81156014)(86362001)(6506007)(8936002)(186003)(7696005)(336012)(26005)(53546011)(9686003)(2906002)(70586007)(4326008)(33656002)(36906005)(55016002)(356004)(316002)(70206006)(6862004)(26826003)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR08MB4933;
 H:64aa7808-outbound-1.mta.getcheckrecipient.com; FPR:; SPF:Pass; LANG:en;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; A:1; MX:1; 
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4f5da827-dcef-4c7a-1e44-08d794c92007
X-Forefront-PRVS: 02778BF158
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pAKm6oAH7aZQoJhUx4qVt6fvpQK6kJGiaFySOlXB4avNz8p9HyHFdalAXGZ8nuNUgOF73gMErtOdtrvgo3sAIfHduKmNNYmvLl7DIhGskS/1kJXe1Px8nRH9l2hrzis7SjIL4qs22oOauNtIQ2xZ0qYGkqiH1oQ7HhQLDnWZtvDYgj3xxlIaN8BssExMPF7ID703CvXXQzHzcYtfEUspBAeGRAQ/wiwN3EExCffEp/sgWCp63AN2wb512u2bZfMX8EiR1gllE3VFBEZ+csXjp0i5n2kjlhyxfXUKFpoCHMNIQsU7QWosPgWvaUlfFlqAsIYPVwom7bhOs82yClyQNdXUyDEemoQ+bcqc6IlvGoc/nE0nMN5EONa5DaNPrAjMdFO+PerFFnWVrgL+2lpmUzD3YFb1+ZpWhjUQgAtOoppTo3rvIRC5Z2SurLCeLfE3C03oPVz0VJFF3Ain3JBQY3yEiK12yf9IbDvAWIx8+6EBOhaYySsdiqnbuCPks80V
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 05:59:53.5514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd20f46-c8c6-40ce-6a5c-08d794c9259d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4933
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
> Sent: Tuesday, January 7, 2020 5:29 PM
> To: Jianyong Wu <Jianyong.Wu@arm.com>
> Cc: netdev@vger.kernel.org; yangbo.lu@nxp.com; john.stultz@linaro.org;
> tglx@linutronix.de; pbonzini@redhat.com; sean.j.christopherson@intel.com;
> richardcochran@gmail.com; Mark Rutland <Mark.Rutland@arm.com>;
> will@kernel.org; Suzuki Poulose <Suzuki.Poulose@arm.com>; Steven Price
> <Steven.Price@arm.com>; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> kvm@vger.kernel.org; Steve Capper <Steve.Capper@arm.com>; Kaly Xin
> <Kaly.Xin@arm.com>; Justin He <Justin.He@arm.com>; nd <nd@arm.com>
> Subject: Re: [RFC PATCH v9 7/8] ptp: arm64: Enable ptp_kvm for arm64
> 
> On 2019-12-10 03:40, Jianyong Wu wrote:
> > Currently in arm64 virtualization environment, there is no mechanism
> > to keep time sync between guest and host. Time in guest will drift
> > compared with host after boot up as they may both use third party time
> > sources to correct their time respectively. The time deviation will be
> > in order of milliseconds but some scenarios ask for higher time
> > precision, like in cloud envirenment, we want all the VMs running in
> > the host aquire the same level accuracy from host clock.
> >
> > Use of kvm ptp clock, which choose the host clock source clock as a
> > reference clock to sync time clock between guest and host has been
> > adopted by x86 which makes the time sync order from milliseconds to
> > nanoseconds.
> >
> > This patch enable kvm ptp on arm64 and we get the similar clock drift
> > as found with x86 with kvm ptp.
> >
> > Test result comparison between with kvm ptp and without it in arm64
> > are as follows. This test derived from the result of command 'chronyc
> > sources'. we should take more cure of the last sample column which
> > shows the offset between the local clock and the source at the last
> > measurement.
> >
> > no kvm ptp in guest:
> > MS Name/IP address   Stratum Poll Reach LastRx Last sample
> >
> ==========================================================
> ==============
> > ^* dns1.synet.edu.cn      2   6   377    13  +1040us[+1581us] +/-
> > 21ms
> > ^* dns1.synet.edu.cn      2   6   377    21  +1040us[+1581us] +/-
> > 21ms
> > ^* dns1.synet.edu.cn      2   6   377    29  +1040us[+1581us] +/-
> > 21ms
> > ^* dns1.synet.edu.cn      2   6   377    37  +1040us[+1581us] +/-
> > 21ms
> > ^* dns1.synet.edu.cn      2   6   377    45  +1040us[+1581us] +/-
> > 21ms
> > ^* dns1.synet.edu.cn      2   6   377    53  +1040us[+1581us] +/-
> > 21ms
> > ^* dns1.synet.edu.cn      2   6   377    61  +1040us[+1581us] +/-
> > 21ms
> > ^* dns1.synet.edu.cn      2   6   377     4   -130us[ +796us] +/-
> > 21ms
> > ^* dns1.synet.edu.cn      2   6   377    12   -130us[ +796us] +/-
> > 21ms
> > ^* dns1.synet.edu.cn      2   6   377    20   -130us[ +796us] +/-
> > 21ms
> >
> > in host:
> > MS Name/IP address   Stratum Poll Reach LastRx Last sample
> >
> ==========================================================
> ==============
> > ^* 120.25.115.20          2   7   377    72   -470us[ -603us] +/-
> > 18ms
> > ^* 120.25.115.20          2   7   377    92   -470us[ -603us] +/-
> > 18ms
> > ^* 120.25.115.20          2   7   377   112   -470us[ -603us] +/-
> > 18ms
> > ^* 120.25.115.20          2   7   377     2   +872ns[-6808ns] +/-
> > 17ms
> > ^* 120.25.115.20          2   7   377    22   +872ns[-6808ns] +/-
> > 17ms
> > ^* 120.25.115.20          2   7   377    43   +872ns[-6808ns] +/-
> > 17ms
> > ^* 120.25.115.20          2   7   377    63   +872ns[-6808ns] +/-
> > 17ms
> > ^* 120.25.115.20          2   7   377    83   +872ns[-6808ns] +/-
> > 17ms
> > ^* 120.25.115.20          2   7   377   103   +872ns[-6808ns] +/-
> > 17ms
> > ^* 120.25.115.20          2   7   377   123   +872ns[-6808ns] +/-
> > 17ms
> >
> > The dns1.synet.edu.cn is the network reference clock for guest and
> > 120.25.115.20 is the network reference clock for host. we can't get
> > the clock error between guest and host directly, but a roughly
> > estimated value will be in order of hundreds of us to ms.
> >
> > with kvm ptp in guest:
> > chrony has been disabled in host to remove the disturb by network
> > clock.
> >
> > MS Name/IP address         Stratum Poll Reach LastRx Last sample
> >
> ==========================================================
> ==============
> > * PHC0                    0   3   377     8     -7ns[   +1ns] +/-
> > 3ns
> > * PHC0                    0   3   377     8     +1ns[  +16ns] +/-
> > 3ns
> > * PHC0                    0   3   377     6     -4ns[   -0ns] +/-
> > 6ns
> > * PHC0                    0   3   377     6     -8ns[  -12ns] +/-
> > 5ns
> > * PHC0                    0   3   377     5     +2ns[   +4ns] +/-
> > 4ns
> > * PHC0                    0   3   377    13     +2ns[   +4ns] +/-
> > 4ns
> > * PHC0                    0   3   377    12     -4ns[   -6ns] +/-
> > 4ns
> > * PHC0                    0   3   377    11     -8ns[  -11ns] +/-
> > 6ns
> > * PHC0                    0   3   377    10    -14ns[  -20ns] +/-
> > 4ns
> > * PHC0                    0   3   377     8     +4ns[   +5ns] +/-
> > 4ns
> >
> > The PHC0 is the ptp clock which choose the host clock as its source
> > clock. So we can be sure to say that the clock error between host and
> > guest is in order of ns.
> >
> > Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> > ---
> >  drivers/clocksource/arm_arch_timer.c | 22 ++++++++++++
> >  drivers/ptp/Kconfig                  |  2 +-
> >  drivers/ptp/ptp_kvm_arm64.c          | 53
> ++++++++++++++++++++++++++++
> >  3 files changed, 76 insertions(+), 1 deletion(-)  create mode 100644
> > drivers/ptp/ptp_kvm_arm64.c
> >
> > diff --git a/drivers/clocksource/arm_arch_timer.c
> > b/drivers/clocksource/arm_arch_timer.c
> > index 277846decd33..72260b66f02e 100644
> > --- a/drivers/clocksource/arm_arch_timer.c
> > +++ b/drivers/clocksource/arm_arch_timer.c
> > @@ -1636,3 +1636,25 @@ static int __init arch_timer_acpi_init(struct
> > acpi_table_header *table)  }  TIMER_ACPI_DECLARE(arch_timer,
> > ACPI_SIG_GTDT, arch_timer_acpi_init);  #endif
> > +
> > +#if IS_ENABLED(CONFIG_PTP_1588_CLOCK_KVM)
> > +#include <linux/arm-smccc.h>
> > +int kvm_arch_ptp_get_crosststamp(unsigned long *cycle, struct
> > timespec64 *ts,
> > +			      struct clocksource **cs)
> > +{
> > +	struct arm_smccc_res hvc_res;
> > +	ktime_t ktime_overall;
> > +
> > +
> 	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_PTP_FU
> NC_ID, &hvc_res);
> > +	if ((long)(hvc_res.a0) < 0)
> > +		return -EOPNOTSUPP;
> > +
> > +	ktime_overall = hvc_res.a0 << 32 | hvc_res.a1;
> > +	*ts = ktime_to_timespec64(ktime_overall);
> > +	*cycle = hvc_res.a2 << 32 | hvc_res.a3;
> 
> So why isn't that just a read of the virtual counter, given that what you do in
> the hypervisor seems to be "cntpct - cntvoff"?
> 
> What am I missing here?
> 
We need get clock time and counter cycle at the same time, so we can't just read virtual counter
at guest and must get it from host.

> > +	*cs = &clocksource_counter;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(kvm_arch_ptp_get_crosststamp);
> > +#endif
> > diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig index
> > 9b8fee5178e8..3c31ff8eb05f 100644
> > --- a/drivers/ptp/Kconfig
> > +++ b/drivers/ptp/Kconfig
> > @@ -110,7 +110,7 @@ config PTP_1588_CLOCK_PCH  config
> > PTP_1588_CLOCK_KVM
> >  	tristate "KVM virtual PTP clock"
> >  	depends on PTP_1588_CLOCK
> > -	depends on KVM_GUEST && X86
> > +	depends on KVM_GUEST && X86 || ARM64 && ARM_ARCH_TIMER
> >  	default y
> >  	help
> >  	  This driver adds support for using kvm infrastructure as a PTP
> > diff --git a/drivers/ptp/ptp_kvm_arm64.c b/drivers/ptp/ptp_kvm_arm64.c
> > new file mode 100644 index 000000000000..f3f957117865
> > --- /dev/null
> > +++ b/drivers/ptp/ptp_kvm_arm64.c
> > @@ -0,0 +1,53 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + *  Virtual PTP 1588 clock for use with KVM guests
> > + *  Copyright (C) 2019 ARM Ltd.
> > + *  All Rights Reserved
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/err.h>
> > +#include <asm/hypervisor.h>
> > +#include <linux/module.h>
> > +#include <linux/psci.h>
> > +#include <linux/arm-smccc.h>
> > +#include <linux/timecounter.h>
> > +#include <linux/sched/clock.h>
> > +#include <asm/arch_timer.h>
> > +
> > +int kvm_arch_ptp_init(void)
> > +{
> > +	struct arm_smccc_res hvc_res;
> > +
> > +
> 	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_PTP_FU
> NC_ID,
> > +			     &hvc_res);
> > +	if ((long)(hvc_res.a0) < 0)
> > +		return -EOPNOTSUPP;
> > +
> > +	return 0;
> > +}
> > +
> > +int kvm_arch_ptp_get_clock_generic(struct timespec64 *ts,
> > +				   struct arm_smccc_res *hvc_res) {
> > +	ktime_t ktime_overall;
> > +
> > +
> 	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_PTP_FU
> NC_ID,
> > +				  hvc_res);
> > +	if ((long)(hvc_res->a0) < 0)
> > +		return -EOPNOTSUPP;
> > +
> > +	ktime_overall = hvc_res->a0 << 32 | hvc_res->a1;
> > +	*ts = ktime_to_timespec64(ktime_overall);
> > +
> > +	return 0;
> > +}
> > +
> > +int kvm_arch_ptp_get_clock(struct timespec64 *ts) {
> > +	struct arm_smccc_res hvc_res;
> > +
> > +	kvm_arch_ptp_get_clock_generic(ts, &hvc_res);
> > +
> > +	return 0;
> > +}
> 
> I also wonder why this is all arm64 specific, while everything should also work
> just fine on 32bit.
>
ptp_kvm is a feature for cloud computing to keep time consistency from container to container and to host on server,
So we focus it on arm64. Also I have never tested it on arm32 machine ( we lack of arm32 machine)
Do you think it's necessary to enable ptp_kvm on arm32? If so, I can do that.
 
Thanks
Jianyong

>          M.
> --
> Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
