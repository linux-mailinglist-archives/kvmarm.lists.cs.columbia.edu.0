Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 11A2BDAA02
	for <lists+kvmarm@lfdr.de>; Thu, 17 Oct 2019 12:29:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B2F8D4AA1E;
	Thu, 17 Oct 2019 06:29:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.908
X-Spam-Level: 
X-Spam-Status: No, score=0.908 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@armh.onmicrosoft.com
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@armh.onmicrosoft.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qtowbTfXTjjG; Thu, 17 Oct 2019 06:29:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 61C3E4AA63;
	Thu, 17 Oct 2019 06:29:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4429A4A8F2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Oct 2019 06:11:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Co3McG58AweV for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Oct 2019 06:11:58 -0400 (EDT)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70083.outbound.protection.outlook.com [40.107.7.83])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9F2114A8EB
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Oct 2019 06:11:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W68CjDz+YFYlGQdlfn1ofOaDeRO0JBLPUa8xxDrqbhc=;
 b=PdpCEzvRh3l9YfJApovR3zzhp7+nA1B6p5cAVizaSQvBBjAs+dS8AcvhwviVzqgr1wOF2oIs3oMZOxUuZuMR46gohA0yRJoALJ2a568bOB7qFTaEO4Lw6jB7VtUZJn7UF0nRt5Sg1h1E7sdghXu3/YjPcNxpMgBHGPSZn8xkojo=
Received: from AM6PR08CA0028.eurprd08.prod.outlook.com (2603:10a6:20b:c0::16)
 by AM6PR08MB3622.eurprd08.prod.outlook.com (2603:10a6:20b:4c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.19; Wed, 16 Oct
 2019 10:11:53 +0000
Received: from DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by AM6PR08CA0028.outlook.office365.com
 (2603:10a6:20b:c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 16 Oct 2019 10:11:53 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.cs.columbia.edu; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.cs.columbia.edu; dmarc=none
 action=none header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT064.mail.protection.outlook.com (10.152.21.199) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 16 Oct 2019 10:11:51 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33");
 Wed, 16 Oct 2019 10:11:33 +0000
X-CR-MTA-TID: 64aa7808
Received: from 584ede32fc7e.2 (ip-172-16-0-2.eu-west-1.compute.internal
 [104.47.5.50]) by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 9F4E5496-4962-42B0-A7F2-540BA592F33F.1; 
 Wed, 16 Oct 2019 10:11:28 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2050.outbound.protection.outlook.com [104.47.5.50])
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 584ede32fc7e.2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
 Wed, 16 Oct 2019 10:11:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8bxk818lSSIZcUAxsoB/o8tuuNWNckQxvJmuUkJ8PjVKAB/uYM6Ll/P8WtR0vk+XiF0XXDZe8rVMd+DEuFYWg52iEcD6Nl1mgBxK2p6es5yMrySl8HZrK8QUPSlHELvGq2DwpHDMhvaSMqqjSqFCXH1sG/d3ZtkRe05nSnHUPmaRc3/GcLuMUuPPSSQ1qMKiOsUoT54KiX4Xj52cqVaF8Sh4q/D5Cdbev1HXHq3a/urHbHH+/52t7vh56fCagbd7A489eVdOwtIXKCDGtiGWLdc97S447pb0bBOCPPettkKD9wvES7q8QCiihKsdbjjxQx2r8rIuywNk4pFe9HxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W68CjDz+YFYlGQdlfn1ofOaDeRO0JBLPUa8xxDrqbhc=;
 b=K36CsZ+OH4mYWzuMxAlb0UCqlyPiDrGFuJfWAVebT8yOh9+CZM3Q51skQYEtPIywU5GkPiL1cT5YHF3ZT+9EjeAxfYm3pJERUr6i6DaBLMPvIztlRnSYEVliQNlVgWur6Z5vQwot7GgexzJezD4GABuzohAycUy+U+7iFCJ9QmT4lmIoA8/1d/CEQQGaFy8X3Wq0cShO/lyb/n9unimwJhhpRdx/CR5VTSMlYvQ6aeu2lQSwktTx9n2EmtUo8sgnCzPMUvIHWYZN03SS9+v3W0yLlljrAuVLDZ2C2+f/SmjdkqzzLN2eqS5BS1ThpeS1tkDUdBkSG0SYjYhOgb1vGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W68CjDz+YFYlGQdlfn1ofOaDeRO0JBLPUa8xxDrqbhc=;
 b=PdpCEzvRh3l9YfJApovR3zzhp7+nA1B6p5cAVizaSQvBBjAs+dS8AcvhwviVzqgr1wOF2oIs3oMZOxUuZuMR46gohA0yRJoALJ2a568bOB7qFTaEO4Lw6jB7VtUZJn7UF0nRt5Sg1h1E7sdghXu3/YjPcNxpMgBHGPSZn8xkojo=
Received: from HE1PR0801MB1676.eurprd08.prod.outlook.com (10.168.146.150) by
 HE1SPR00MB244.eurprd08.prod.outlook.com (10.171.98.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 10:11:25 +0000
Received: from HE1PR0801MB1676.eurprd08.prod.outlook.com
 ([fe80::b056:4113:e0bd:110d]) by HE1PR0801MB1676.eurprd08.prod.outlook.com
 ([fe80::b056:4113:e0bd:110d%6]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 10:11:25 +0000
From: "Jianyong Wu (Arm Technology China)" <Jianyong.Wu@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "yangbo.lu@nxp.com" <yangbo.lu@nxp.com>,
 "john.stultz@linaro.org" <john.stultz@linaro.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "sean.j.christopherson@intel.com"
 <sean.j.christopherson@intel.com>, "maz@kernel.org" <maz@kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>, Mark Rutland
 <Mark.Rutland@arm.com>, "will@kernel.org" <will@kernel.org>, Suzuki Poulose
 <Suzuki.Poulose@arm.com>
Subject: RE: [PATCH v5 5/6] ptp: arm64: Enable ptp_kvm for arm64
Thread-Topic: [PATCH v5 5/6] ptp: arm64: Enable ptp_kvm for arm64
Thread-Index: AQHVg0Y6A4wUAbusSUOkn5f/2HpSwadb56wAgAC7jVCAADfWgIAAAOYAgAAwG2A=
Date: Wed, 16 Oct 2019 10:11:25 +0000
Message-ID: <HE1PR0801MB1676412E33493247F7C37C6CF4920@HE1PR0801MB1676.eurprd08.prod.outlook.com>
References: <20191015104822.13890-1-jianyong.wu@arm.com>
 <20191015104822.13890-6-jianyong.wu@arm.com>
 <da62c327-9402-9a5c-d694-c1a4378822e0@redhat.com>
 <HE1PR0801MB167654440A67AF072E28FFFDF4920@HE1PR0801MB1676.eurprd08.prod.outlook.com>
 <6e9bfd40-4715-74b3-b5d4-fc49329bed24@redhat.com>
 <140551c1-b56d-0942-58b3-61a1f5331e83@redhat.com>
In-Reply-To: <140551c1-b56d-0942-58b3-61a1f5331e83@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 14dea4f2-b891-4ba3-9452-a89be0130161.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Jianyong.Wu@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 18c7672a-0eab-4752-4f0f-08d752214386
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: HE1SPR00MB244:|HE1SPR00MB244:|AM6PR08MB3622:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB36222FCF51BF1F85EECC220CF4920@AM6PR08MB3622.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 0192E812EC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(189003)(199004)(13464003)(53546011)(14454004)(7696005)(76176011)(55016002)(5660300002)(86362001)(316002)(476003)(6436002)(9686003)(3846002)(11346002)(6116002)(446003)(99286004)(7416002)(66066001)(110136005)(186003)(102836004)(6506007)(26005)(54906003)(256004)(71200400001)(2501003)(2201001)(33656002)(52536014)(71190400001)(55236004)(486006)(6636002)(74316002)(305945005)(478600001)(25786009)(7736002)(76116006)(8676002)(66476007)(8936002)(81156014)(64756008)(66446008)(66556008)(66946007)(4326008)(6246003)(229853002)(2906002)(81166006)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1SPR00MB244;
 H:HE1PR0801MB1676.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: X2rvBiNwCxruNT+7VAx6SGWdAs3F25IT5iNnDekCGw/xHwdKRks7GybByEneFEuYYXTQksaq64hKAj5lx5nWG4CC4d+ITk4nftyrU8/Rth6EDRNBNA3iFVvgKKpqgx3G4vwUy3wgL/A8b+/Oy9BAJaXWDvrOSzZYE6UZF3ZZkO8MQrMa25Q9Z+BIpPeI6pe7+agSKos0tOjO3rXCAorc6O0C7rCCEDoYGn57A7aWzgtDfoJzWMeuZmzbWlXs4k5Jr3uP9fSuZNzDcaPsApS0PWwpwYcqcRKfUh8mkcNVVhVyJJGGKtGPymoa9A1CFEXWvOTaLTTyfv10xlKKccUcQxUDn6DoK9kF5Ax/1+qWq0a2XNntkgrI5MCZY3UNuAyWaf2jp7pji9WIkUhSj/nzSCVTpsPcT7lIzwFUlNKhhSY=
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1SPR00MB244
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jianyong.Wu@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123; IPV:CAL; SCL:-1; CTRY:IE;
 EFV:NLI; SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(136003)(346002)(199004)(13464003)(189003)(14454004)(76130400001)(305945005)(99286004)(66066001)(8936002)(9686003)(26005)(25786009)(7736002)(7696005)(110136005)(23676004)(76176011)(2486003)(74316002)(70206006)(70586007)(4326008)(33656002)(6636002)(2501003)(102836004)(316002)(186003)(54906003)(47776003)(446003)(53546011)(436003)(22756006)(356004)(6246003)(55016002)(6506007)(86362001)(229853002)(486006)(50466002)(6116002)(26826003)(478600001)(63350400001)(5660300002)(126002)(476003)(2906002)(336012)(2201001)(52536014)(3846002)(81166006)(8676002)(81156014)(11346002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR08MB3622;
 H:64aa7808-outbound-1.mta.getcheckrecipient.com; FPR:; SPF:TempError; LANG:en;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; A:1; MX:1; 
X-MS-Office365-Filtering-Correlation-Id-Prvs: e80cd277-4ded-4285-dc25-08d752213433
NoDisclaimer: True
X-Forefront-PRVS: 0192E812EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qoijAH8jdOHQQniCeW6uVjTNfCRQbjs2hq5OTgQv/i+XLs64yL9e5QNjkTIDb8qZsW6AI5slcGyFbplasD3EAGsMuEYbvGamzrK3i+VRayYlcQsJCRQ0xCaVmNbhwH6byiPIqERaFYUHUTbVt30khN3xuaTaviaZeH0oON+KayMUwSxv8yj2yiz/qD2JXsgvcMCc3LF0bxL2RJ7w1YbxgnjqZh4hB+VRGgprMVBameWo8AijSVZ4E1WWjOqqj+DXYF9MQo6ZXucUMr1fE4AIuNAlh33JmeKZDMQuGUa8i+qbTe5fATd4G0fHKa3FHqtg0wPG3UY5974vt41mBSyhKBEkm15gGsb7/tbvrXnkyjU6MbzSyeRuf2Col/7OJXYTKZaJCdd+WuLjWY4zrGSyGJNob2fEVUc+Ys7/WQGCVro=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 10:11:51.4807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c7672a-0eab-4752-4f0f-08d752214386
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3622
X-Mailman-Approved-At: Thu, 17 Oct 2019 06:29:20 -0400
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

Hi Paolo,

> -----Original Message-----
> From: Paolo Bonzini <pbonzini@redhat.com>
> Sent: Wednesday, October 16, 2019 3:14 PM
> To: Jianyong Wu (Arm Technology China) <Jianyong.Wu@arm.com>;
> netdev@vger.kernel.org; yangbo.lu@nxp.com; john.stultz@linaro.org;
> tglx@linutronix.de; sean.j.christopherson@intel.com; maz@kernel.org;
> richardcochran@gmail.com; Mark Rutland <Mark.Rutland@arm.com>;
> will@kernel.org; Suzuki Poulose <Suzuki.Poulose@arm.com>
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> kvmarm@lists.cs.columbia.edu; kvm@vger.kernel.org; Steve Capper
> <Steve.Capper@arm.com>; Kaly Xin (Arm Technology China)
> <Kaly.Xin@arm.com>; Justin He (Arm Technology China)
> <Justin.He@arm.com>; nd <nd@arm.com>
> Subject: Re: [PATCH v5 5/6] ptp: arm64: Enable ptp_kvm for arm64
> 
> On 16/10/19 09:10, Paolo Bonzini wrote:
> > On 16/10/19 05:52, Jianyong Wu (Arm Technology China) wrote:
> >> This func used only by kvm_arch_ptp_get_clock and nothing to do with
> >> kvm_arch_ptp_get_clock_fn. Also it can be merged into
> >> kvm_arch_ptp_get_clock.
> >>
> >
> > Your patches also have no user for kvm_arch_ptp_get_clock, so you can
> > remove it.
> 
> Nevermind.  I misread patch 2.  However, to remove the confusion, can you
> rename kvm_arch_ptp_get_clock_fn to kvm_arch_ptp_get_crosststamp?
> 

the suffix of this function name is reserved from its arch-independent caller ptp_kvm_get_time_fn, so if I change this function name
It will be better change them whole. I think "ptp_get_crosststamp" is a better suffix.

Thanks
Jianyong 

> Paolo

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
