Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BB3FBF2727
	for <lists+kvmarm@lfdr.de>; Thu,  7 Nov 2019 06:35:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D6A924ACBB;
	Thu,  7 Nov 2019 00:35:06 -0500 (EST)
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
	with ESMTP id BMd9uUchDI4d; Thu,  7 Nov 2019 00:35:06 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5DFC44ACAB;
	Thu,  7 Nov 2019 00:35:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C13F4A95D
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 Nov 2019 00:35:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X-zQkIdXYe2X for <kvmarm@lists.cs.columbia.edu>;
 Thu,  7 Nov 2019 00:35:01 -0500 (EST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 210384A5A0
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 Nov 2019 00:35:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aq/J6v0LifJ6OFBqdGet6GLcKYfUpXBrWRsxGGHGO9I=;
 b=ny/D6uOqZdvuS/i3SrrjAcjRiHu/hkNN+AZXfKu8ONM3UbgMRQoWEiKP9GHa0mM+GIR4CkTpVd3Ws6tr+IqRanbD+V4nTQnOA8QJR10p9by7Un+1I2QHLG5cYlCszW+MIwArNsmeO1GmhlMoGnG2Uosdxt+D1LWUOzaXj0kodyI=
Received: from HE1PR0802CA0004.eurprd08.prod.outlook.com (2603:10a6:3:bd::14)
 by AM6PR08MB3656.eurprd08.prod.outlook.com (2603:10a6:20b:51::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Thu, 7 Nov
 2019 05:34:58 +0000
Received: from VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by HE1PR0802CA0004.outlook.office365.com
 (2603:10a6:3:bd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 05:34:58 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.cs.columbia.edu; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.cs.columbia.edu; dmarc=none
 action=none header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT055.mail.protection.outlook.com (10.152.19.158) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Thu, 7 Nov 2019 05:34:56 +0000
Received: ("Tessian outbound e4042aced47b:v33");
 Thu, 07 Nov 2019 05:34:50 +0000
X-CR-MTA-TID: 64aa7808
Received: from 9e95d7f11c10.3 (cr-mta-lb-1.cr-mta-net [104.47.5.56])
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 440E1969-964B-4A61-9502-1EE80A817CC2.1; 
 Thu, 07 Nov 2019 05:34:45 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2056.outbound.protection.outlook.com [104.47.5.56])
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9e95d7f11c10.3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Thu, 07 Nov 2019 05:34:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONxAKtaS/YCfvagOouu+wKe9lxfy8lsKfdGVQykymxgBkMW1FCaxkSRcI9hE48ZzhkK1mdfB7mgkixXVw8Xa+cnqkXpYa5Jkr3O93OMQ9uUQguCevNMgmEyx9S7Ho1BYhXVUXJwg/06tGf5qVqDCoHPTbMtC6z9usszqXS2zx0cZLCJKluKdGAH6aYN+WvizteKlqfYqoPsVOighMch2fVXoPNGiBDCM4fsic+SjLCvD0FNOk82HC+tUJeI9LR8Ijz5igTRNuvAK6Q6wDFTeN9xcWS1YPAaw+aTxU+vYuR6Co+UArSw85/arLYbO/mcczOOWAmK1PVD5QgmJpt+94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aq/J6v0LifJ6OFBqdGet6GLcKYfUpXBrWRsxGGHGO9I=;
 b=O1nqc74pdfUlEEeVliGZH9s9Yv65Onl97pW+H/yarePsmvGp7vOmn9l/ehKm2lo+XWRvLaNLrx7MEnVHJZEWlaGbnhPBkaE96mXOBgWcIHC6diG9LaMHGCns6xCpsIbT9GmH/XGDAb6f4+PsbNTmu5pxIhZH+I5bekZsMKmnC3c3WNLnoL3vRzp7UNHel2wkyh+4zyNcSLLMA6C9HcoXd0omKFKWvB8d7Yg1pOA4pfggCFDpa4hQT9eSzVsq9eH4WR+YgOq/4Sw/3b+VCY0a2oWnX79PbvTi/ClcL/uj/cqZZIxdEWcoJmBSwpoQVQ+2ip1CmKC4xuobNJjgUv1MUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aq/J6v0LifJ6OFBqdGet6GLcKYfUpXBrWRsxGGHGO9I=;
 b=ny/D6uOqZdvuS/i3SrrjAcjRiHu/hkNN+AZXfKu8ONM3UbgMRQoWEiKP9GHa0mM+GIR4CkTpVd3Ws6tr+IqRanbD+V4nTQnOA8QJR10p9by7Un+1I2QHLG5cYlCszW+MIwArNsmeO1GmhlMoGnG2Uosdxt+D1LWUOzaXj0kodyI=
Received: from AM5PR0801MB1668.eurprd08.prod.outlook.com (10.169.247.142) by
 AM5PR0801MB2083.eurprd08.prod.outlook.com (10.168.159.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 05:34:42 +0000
Received: from AM5PR0801MB1668.eurprd08.prod.outlook.com
 ([fe80::b5a2:1e32:3cce:c73f]) by AM5PR0801MB1668.eurprd08.prod.outlook.com
 ([fe80::b5a2:1e32:3cce:c73f%8]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 05:34:42 +0000
From: "Jianyong Wu (Arm Technology China)" <Jianyong.Wu@arm.com>
To: "Jianyong Wu (Arm Technology China)" <Jianyong.Wu@arm.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "yangbo.lu@nxp.com"
 <yangbo.lu@nxp.com>, "john.stultz@linaro.org" <john.stultz@linaro.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "sean.j.christopherson@intel.com"
 <sean.j.christopherson@intel.com>, "maz@kernel.org" <maz@kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>, Mark Rutland
 <Mark.Rutland@arm.com>, "will@kernel.org" <will@kernel.org>, Suzuki Poulose
 <Suzuki.Poulose@arm.com>
Subject: RE: [RFC PATCH v6 0/7] Enable ptp_kvm for arm64
Thread-Topic: [RFC PATCH v6 0/7] Enable ptp_kvm for arm64
Thread-Index: AQHVilqKBt2nCL8qy0i/hHF7qKoNRKd/QL9g
Date: Thu, 7 Nov 2019 05:34:42 +0000
Message-ID: <AM5PR0801MB1668A2981FE88C42C3C28A97F4780@AM5PR0801MB1668.eurprd08.prod.outlook.com>
References: <20191024110209.21328-1-jianyong.wu@arm.com>
In-Reply-To: <20191024110209.21328-1-jianyong.wu@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: aef44de8-8bc5-4639-8764-61708dc25195.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Jianyong.Wu@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ac2fc4cd-d061-4b13-198e-08d76344398d
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2083:|AM5PR0801MB2083:|AM6PR08MB3656:
X-MS-Exchange-PUrlCount: 2
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3656AD6371C94491195EFB64F4780@AM6PR08MB3656.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1284;OLM:1284;
x-forefront-prvs: 0214EB3F68
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39840400004)(396003)(346002)(136003)(376002)(199004)(189003)(53754006)(13464003)(54534003)(76176011)(66446008)(33656002)(55016002)(66946007)(102836004)(6436002)(53546011)(66476007)(9686003)(6306002)(5660300002)(7696005)(476003)(54906003)(110136005)(66066001)(55236004)(26005)(229853002)(71200400001)(7416002)(6506007)(81156014)(52536014)(8936002)(81166006)(8676002)(186003)(6116002)(71190400001)(4326008)(305945005)(2906002)(256004)(478600001)(99286004)(316002)(6246003)(76116006)(2201001)(446003)(11346002)(86362001)(2501003)(14454004)(7736002)(64756008)(25786009)(6636002)(486006)(66556008)(74316002)(3846002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR0801MB2083;
 H:AM5PR0801MB1668.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: nQa5t9/4Pg3LP7mMY5JvMMbckFXyhGcsVWL7SWmbCg4ZwkUbluCmvxvLjpi7WgvbuE8KFf1dOIqCDAexciTSLDhFLkfu1BdhyBiwK/3stSAlsywf1zRhE0HjNbFkDOY+Ne1ygbInOKXYq02edz9cACrcW6v5ME3Vi16nqeTj6+ZZamce8UwiWqKgYp+D3zKMe+/PbAUrifO4L6d+rTXXQE1/tyG4N2XWvVMv2N0+Zg3O5M8RhEpaGtwmMFFk1To45ho84rN7rQD9NQpgzWqztBNEGvSICRnYXsfT9oYkDurcWFk0TaWTQHU3A7NdK9okXPeXlrvsZ8Pu0nTSD1EhmKuIQsPapJjx4SF3LxPMRZC029V+DcZKahCrK2+uHxQGRq8t6KiwccVAEZV1TLC5NESe5EQEJrShI46xUfVVUlRW/m4I4Wo6biVS55Zm/bsh0D4d01H291yLRELHx3mP6ExHQaNe1thQs2ejFzk3q+8=
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2083
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jianyong.Wu@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123; IPV:CAL; SCL:-1; CTRY:IE;
 EFV:NLI; SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(1110001)(339900001)(13464003)(54534003)(199004)(189003)(53754006)(22756006)(70206006)(70586007)(9686003)(47776003)(66066001)(102836004)(50466002)(478600001)(26826003)(5660300002)(33656002)(6306002)(7696005)(105606002)(55016002)(6506007)(86362001)(53546011)(4326008)(2201001)(3846002)(476003)(2501003)(126002)(11346002)(446003)(97756001)(76176011)(6116002)(23726003)(486006)(2906002)(6636002)(26005)(7736002)(110136005)(99286004)(356004)(6246003)(46406003)(36906005)(316002)(14454004)(8676002)(186003)(25786009)(54906003)(52536014)(74316002)(76130400001)(8746002)(336012)(305945005)(81166006)(81156014)(229853002)(8936002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR08MB3656;
 H:64aa7808-outbound-1.mta.getcheckrecipient.com; FPR:; SPF:Fail; LANG:en;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; A:1; MX:1; 
X-MS-Office365-Filtering-Correlation-Id-Prvs: 39723c41-59a1-446d-baba-08d7634430e4
NoDisclaimer: True
X-Forefront-PRVS: 0214EB3F68
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5HMVf7OeFMasplYP8LJkud7F/xT99xiJk5+xuybG/7uOoZ5K2T0ChFX+6TYEGuDyUhyQOiPZFloNnIrBXM7uk1ORs83Kxbn4n33uQeia17yYUniw+99uNJYKlyPd+N0PWtlgQ6jU48RlcCB3aLJWwPGCCNwguoG9c1XLx43lj+qsO3ESXXaEG7OJl1oOqYXf+SYxENPqFI5UDEH2yL0+LZH+666W/DpSc1NKAFQ8xFsPiZoeWszJ2Ma/vf7n4lKUBkfz/9D0pZYTjzF/GCNnDsb0MJ9pRR9SYJwXdtwZIYWGFeeJhQlTb4GpKYONVbVy0IDs94o7GcLUa0nbliZPMZ+NLHGImpLB9GX4VmdV7ibb/ZyA1h+r/RkoXsk2Typo3PjeZ5rTBc2D48xLqvKp1+JSqnoCadvElW7CAqSS2LofcOTM6KDSPtPTHWVQXTLvn1S1/Yv9CXjAw/rK7w9Fw3qdFuYOJYnplcdgsi1t/A=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 05:34:56.9658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2fc4cd-d061-4b13-198e-08d76344398d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3656
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

Hi all,

Any comments?

Thanks
Jianyong

> -----Original Message-----
> From: Jianyong Wu <jianyong.wu@arm.com>
> Sent: Thursday, October 24, 2019 7:02 PM
> To: netdev@vger.kernel.org; yangbo.lu@nxp.com; john.stultz@linaro.org;
> tglx@linutronix.de; pbonzini@redhat.com; sean.j.christopherson@intel.com;
> maz@kernel.org; richardcochran@gmail.com; Mark Rutland
> <Mark.Rutland@arm.com>; will@kernel.org; Suzuki Poulose
> <Suzuki.Poulose@arm.com>
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> kvmarm@lists.cs.columbia.edu; kvm@vger.kernel.org; Steve Capper
> <Steve.Capper@arm.com>; Kaly Xin (Arm Technology China)
> <Kaly.Xin@arm.com>; Justin He (Arm Technology China)
> <Justin.He@arm.com>; Jianyong Wu (Arm Technology China)
> <Jianyong.Wu@arm.com>; nd <nd@arm.com>
> Subject: [RFC PATCH v6 0/7] Enable ptp_kvm for arm64
> 
> kvm ptp targets to provide high precision time sync between guest and host
> in virtualization environment. This patch enable kvm ptp for arm64.
> This patch set base on [1][2][3]
> 
> change log:
> from v5 to v6:
>         (1) apply Mark's patch[4] to get SMCCC conduit.
>         (2) add mechanism to recognize current clocksource by add
> clocksouce_id value into struct clocksource instead of method in patch-v5.
>         (3) rename kvm_arch_ptp_get_clock_fn into
> kvm_arch_ptp_get_crosststamp.
> 
> from v4 to v5:
>         (1) remove hvc delay compensasion as it should leave to userspace.
>         (2) check current clocksource in hvc call service.
>         (3) expose current clocksource by adding it to system_time_snapshot.
>         (4) add helper to check if clocksource is arm_arch_counter.
>         (5) rename kvm_ptp.c to ptp_kvm_common.c
> 
> from v3 to v4:
>         (1) fix clocksource of ptp_kvm to arch_sys_counter.
>         (2) move kvm_arch_ptp_get_clock_fn into arm_arch_timer.c
>         (3) subtract cntvoff before return cycles from host.
>         (4) use ktime_get_snapshot instead of getnstimeofday and
> get_current_counterval to return time and counter value.
>         (5) split ktime and counter into two 32-bit block respectively to avoid
> Y2038-safe issue.
>         (6) set time compensation to device time as half of the delay of hvc call.
>         (7) add ARM_ARCH_TIMER as dependency of ptp_kvm for arm64.
> 
> from v2 to v3:
>         (1) fix some issues in commit log.
>         (2) add some receivers in send list.
> 
> from v1 to v2:
>         (1) move arch-specific code from arch/ to driver/ptp/
>         (2) offer mechanism to inform userspace if ptp_kvm service is available.
>         (3) separate ptp_kvm code for arm64 into hypervisor part and guest part.
>         (4) add API to expose monotonic clock and counter value.
>         (5) refine code: remove no necessary part and reconsitution.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/
> commit/?h=kvm/hvc&id=125ea89e4a21e2fc5235410f966a996a1a7148bf
> [2]https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/
> commit/?h=kvm/hvc&id=464f5a1741e5959c3e4d2be1966ae0093b4dce06
> [3]https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/
> commit/?h=kvm/hvc&id=6597490e005d0eeca8ed8c1c1d7b4318ee014681
> [4]https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/
> commit/?h=for-next/smccc-conduit-
> cleanup&id=6b7fe77c334ae59fed9500140e08f4f896b36871
> 
> Jianyong Wu (6):
>   psci: let arm_smccc_1_1_invoke available by modules
>   ptp: Reorganize ptp_kvm modules to make it arch-independent.
>   time: Add mechanism to recognize clocksource in time_get_snapshot
>   psci: Add hvc call service for ptp_kvm.
>   ptp: arm64: Enable ptp_kvm for arm64
>   kvm: arm64: Add capability check extension for ptp_kvm
> 
> Mark Rutland (1):
>   arm/arm64: smccc/psci: add arm_smccc_1_1_get_conduit()
> 
>  drivers/clocksource/arm_arch_timer.c        | 24 ++++++
>  drivers/firmware/psci/psci.c                | 16 ++++
>  drivers/ptp/Kconfig                         |  2 +-
>  drivers/ptp/Makefile                        |  1 +
>  drivers/ptp/ptp_kvm_arm64.c                 | 53 +++++++++++++
>  drivers/ptp/{ptp_kvm.c => ptp_kvm_common.c} | 77 +++++-------------
>  drivers/ptp/ptp_kvm_x86.c                   | 87 +++++++++++++++++++++
>  include/asm-generic/ptp_kvm.h               | 12 +++
>  include/clocksource/arm_arch_timer.h        |  4 +
>  include/linux/arm-smccc.h                   | 30 ++++++-
>  include/linux/clocksource.h                 |  6 ++
>  include/linux/timekeeping.h                 | 12 +--
>  include/uapi/linux/kvm.h                    |  1 +
>  kernel/time/clocksource.c                   |  3 +
>  kernel/time/timekeeping.c                   |  1 +
>  virt/kvm/arm/arm.c                          |  1 +
>  virt/kvm/arm/psci.c                         | 22 ++++++
>  17 files changed, 286 insertions(+), 66 deletions(-)  create mode 100644
> drivers/ptp/ptp_kvm_arm64.c  rename drivers/ptp/{ptp_kvm.c =>
> ptp_kvm_common.c} (63%)  create mode 100644
> drivers/ptp/ptp_kvm_x86.c  create mode 100644 include/asm-
> generic/ptp_kvm.h
> 
> --
> 2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
