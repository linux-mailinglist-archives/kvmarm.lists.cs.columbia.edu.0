Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A2E0025F581
	for <lists+kvmarm@lfdr.de>; Mon,  7 Sep 2020 10:40:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2EF724B5AD;
	Mon,  7 Sep 2020 04:40:59 -0400 (EDT)
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
	with ESMTP id rmgL6ouTrgR3; Mon,  7 Sep 2020 04:40:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 709FC4B5B4;
	Mon,  7 Sep 2020 04:40:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F0E9D4B5AD
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Sep 2020 04:40:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n0VMRe9Rp0YQ for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Sep 2020 04:40:54 -0400 (EDT)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 08B4A4B5AC
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Sep 2020 04:40:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/F46zTBEG7jPqbH0Xek3LbfaBA0a1ttbag9I+ByAH4Y=;
 b=KAXnGL15F6sTuZBaYiNHOz8YA6P8T2xUl1DsUJvLzhmOxY+SwTCQRmiROFUfm1oyz7m14hMLvh2FKPnKzRafWtTvSI1Vsm5wWK78xq3PIMerzf9dqKig0Rhq4Ehu7uXzxnPPXimmlvZZJiIhWuQYKUak1Ppr7aba2cbUHAAMoOk=
Received: from MRXP264CA0003.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:15::15)
 by DB8PR08MB5321.eurprd08.prod.outlook.com (2603:10a6:10:11c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 08:40:52 +0000
Received: from VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:15:cafe::58) by MRXP264CA0003.outlook.office365.com
 (2603:10a6:500:15::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Mon, 7 Sep 2020 08:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
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
 15.20.3326.19 via Frontend Transport; Mon, 7 Sep 2020 08:40:51 +0000
Received: ("Tessian outbound 7fc8f57bdedc:v64");
 Mon, 07 Sep 2020 08:40:42 +0000
X-CR-MTA-TID: 64aa7808
Received: from a29f4acfd86b.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 E17A232C-7AA1-4B77-A410-2BE4039E7784.1; 
 Mon, 07 Sep 2020 08:40:37 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a29f4acfd86b.2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Mon, 07 Sep 2020 08:40:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0eDa7r/gGUI/oad5l1Rqf7EYtATgQ0fsz9NsGOsYL97SHITHfDhxQx4z9xfw/K00BL56G9oLpU3rXoL/FxuSBUb46jTZlKTlfgTGHU7nEOpONSrkOg3WKt7J761mgjFIt6Ga7k9l3aOtQBRwzK47/EvV2NLN6Aujw/aXxi46KpbAaylms/Lm8RySYfixgTmmtE7tvzSF2wMjGarS0drr3h7/hGxlKYEC8cHpx6lX4xtB9amm3rJu/5nydkCNtt+eAoroKC3x+8/NOkEBg4rwpaRWiUQQ4pCGTakGDrEWdrtsE9SoT40zlASFuvlw6tEYYEt0vXkaympiUQoMkRvpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/F46zTBEG7jPqbH0Xek3LbfaBA0a1ttbag9I+ByAH4Y=;
 b=FhRUQr0pWAa13HCuvH1VQBkln8edeqFttEH/XEvzZBN5NGjl35xq0n5KvrciRitr7rkWvPUPdyxAu6RmztsOOfJPtLYsaesU0Eb0DbECIhLuHzINcMXZXY21rtWccgBp+COXB4exymSdLBagpArkjd/wWz5WVhPBJSxlyZOV1K03nf11Qceey8T/a1g94VFcl4wwdjRCMaca2dsfRiRsfKRuJpg1rGyc6Nb63hmPbE6wWN0FWP/nqpCs6sj3H56glkyqGUYAtVtu5qFr2Z7UsutcGrUJ3D987ICeVppRCHI/jjWKKRHBC/lhRDgwpTmW8xjBU5Bba7J+ol1MNo20cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/F46zTBEG7jPqbH0Xek3LbfaBA0a1ttbag9I+ByAH4Y=;
 b=KAXnGL15F6sTuZBaYiNHOz8YA6P8T2xUl1DsUJvLzhmOxY+SwTCQRmiROFUfm1oyz7m14hMLvh2FKPnKzRafWtTvSI1Vsm5wWK78xq3PIMerzf9dqKig0Rhq4Ehu7uXzxnPPXimmlvZZJiIhWuQYKUak1Ppr7aba2cbUHAAMoOk=
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com (2603:10a6:3:e0::7)
 by HE1PR0801MB1723.eurprd08.prod.outlook.com (2603:10a6:3:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Mon, 7 Sep
 2020 08:40:35 +0000
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::74f7:5759:4e9e:6e00]) by HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::74f7:5759:4e9e:6e00%5]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 08:40:35 +0000
From: Jianyong Wu <Jianyong.Wu@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH v14 08/10] ptp: arm64: Enable ptp_kvm for arm64
Thread-Topic: [PATCH v14 08/10] ptp: arm64: Enable ptp_kvm for arm64
Thread-Index: AQHWgp4Q48WtGxJp4kuFSJTL6o01LqlZ4qMAgAL3/tA=
Date: Mon, 7 Sep 2020 08:40:34 +0000
Message-ID: <HE1PR0802MB2555CC56351616836A95FB19F4280@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <20200904092744.167655-1-jianyong.wu@arm.com>
 <20200904092744.167655-9-jianyong.wu@arm.com> <874kocmqqx.wl-maz@kernel.org>
In-Reply-To: <874kocmqqx.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 05439A53E400A545A8EE379138E1C161.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e5443f11-5c6e-4ed3-04af-08d85309ba3a
x-ms-traffictypediagnostic: HE1PR0801MB1723:|DB8PR08MB5321:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB53219AC2414854E85039E86AF4280@DB8PR08MB5321.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:4714;OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8o2ttfJ7g0aB7CFSbNEUOGOB3im5cJZHBfBad4KzMIeHHv7kWO8S6I2LSsxty+HC3cVjjV62ZZWTpaq6vFhyaNXL8zlYgB7QyxAVvDKa9K7lj6f2ECWGGjy+DGacfHfr8V4DiJW1aupVlCgsZN8Vm19PvJw9HDfmOQSJRjCbKjwN/ZKYJ90AywE/OM+J/yM72xT9Gk2s1nvGYaujqWLhURneUcC24RHDrVxsw+MVX3LX+xjlrlJiUC3OQaZmriMYtyskXJMcpzun1S1rkI/jniT0ZbqSXk2O8XJiLqUuskrkSVhCD+eUP3Iq+Ax9WRk4n+yQf0Cy1xNJBNqpw+lrLg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:HE1PR0802MB2555.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(53546011)(66476007)(26005)(4326008)(64756008)(66556008)(2906002)(66946007)(66446008)(186003)(54906003)(6916009)(76116006)(83380400001)(9686003)(478600001)(55016002)(86362001)(7696005)(6506007)(316002)(71200400001)(8936002)(8676002)(5660300002)(52536014)(33656002)(7416002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: lsOWCE7O0tevz3AhdOuy//g2OGwZjvIcNr5xRD5vrzj9FDDozQUmpGJI5FVk0lNdBpWnzye5SJKIGtI6Gc1Sora/nIxDtf3Kakmm3ufdJ3aCYwMPtddUofPKrRptqwWVwVcL8ki+E05v+AqakQdrL64M1fL0vtoaDSvp9VKMvDO/Qubc1iimMmqptdXcvVtX3tp2sZc6n+Bijf79m33pSLsw44oU/Qae9pPUasPWGMXl6e8SS8NZtlQ5rBxpBSmdkFukBHeg0QGAtNeXze4TAeqsK0Qqd4I1orVXoNmLOXfVm3YG4VAqRQjyP5njuQrdesZ+9ceqUsLDbnSnBltQXk383X7xkE9b+z4cszHT+vfz6xMRZzjHJjENHpfSHeNEAzTu+/loCvJOOJch9UXmWNO+s0gxzSxDSL1eXyCnl9Pa4BiZV2X7tJXsslxk006UvJOZaRq68Na1dFWdLUMhbxKwSsuv/9x/BRDYqrvE6BJZzrc4azDW/39cV9p+j25F66RxoSaVw6hKxoJW7rzsWteqF0xe2dW3es/WWP+FxNV51hWw4ed9AZzzkAoLR98i38+3Sjhfj87j2F+Kbt5ykT4dpImNgXvV8jmg+zvgLXSBh5QnFh4x+inICP+S567qbyOkpcVdo/tWu7hzNIxY2w==
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1723
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9df72dc2-10a0-4b53-b5fb-08d85309b054
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sUOqeKR4sGplcPySdB87/ebtYFUpgfTbdgx+T8lL5Am1zNjV7vQeUgoG4GmA36rHp/EcNFUTp1kM0FTWaD/2nhklEUonTXnJ1kY+ErHUQk7EVJ7LD+PUFrzSO8rG8MCapKmbBV/Kq9FjLlwF+1cLYAtHMctPuGxbO+qwUaulelsaq3UxdgdrkSrQIjD5ryyDQUZom+HJGbJv4j9hjBHR1EJmy0IOmp6iLx7yXE2RTIsmMEvvQud1Pcu672c+rzpIIKge6aK/66PIsyfOLWw0EHcaFzJ9XeCPcRItrdREWSbTeTez3aljEtK6u1xFoO6zlQv3kWqnBvqT4FXOeKTk97dSpBgJ9tg9FvZYUYxfEogcx7lcNBmMQwXRJHPYhS90DCw4vvlY47hi+laISgm/xA==
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966005)(52536014)(478600001)(2906002)(26005)(7696005)(8936002)(8676002)(36906005)(33656002)(9686003)(316002)(53546011)(6506007)(336012)(55016002)(70586007)(70206006)(186003)(86362001)(82740400003)(4326008)(5660300002)(83380400001)(81166007)(47076004)(6862004)(82310400003)(54906003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 08:40:51.5551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5443f11-5c6e-4ed3-04af-08d85309ba3a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5321
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
> Sent: Saturday, September 5, 2020 7:02 PM
> To: Jianyong Wu <Jianyong.Wu@arm.com>
> Cc: netdev@vger.kernel.org; yangbo.lu@nxp.com; john.stultz@linaro.org;
> tglx@linutronix.de; pbonzini@redhat.com; sean.j.christopherson@intel.com;
> richardcochran@gmail.com; Mark Rutland <Mark.Rutland@arm.com>;
> will@kernel.org; Suzuki Poulose <Suzuki.Poulose@arm.com>; Steven Price
> <Steven.Price@arm.com>; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> kvm@vger.kernel.org; Steve Capper <Steve.Capper@arm.com>; Justin He
> <Justin.He@arm.com>; nd <nd@arm.com>
> Subject: Re: [PATCH v14 08/10] ptp: arm64: Enable ptp_kvm for arm64
> 
> On Fri, 04 Sep 2020 10:27:42 +0100,
> Jianyong Wu <jianyong.wu@arm.com> wrote:
> >
> > Currently, there is no mechanism to keep time sync between guest and
> > host in arm64 virtualization environment. Time in guest will drift
> > compared with host after boot up as they may both use third party time
> > sources to correct their time respectively. The time deviation will be
> > in order of milliseconds. But in some scenarios,like in cloud
> > envirenment, we ask for higher time precision.
> >
> > kvm ptp clock, which choose the host clock source as a reference clock
> > to sync time between guest and host, has been adopted by x86 which
> > makes the time sync order from milliseconds to nanoseconds.
> >
> > This patch enables kvm ptp clock for arm64 and improve clock sync
> > precison significantly.
> >
> > Test result comparisons between with kvm ptp clock and without it in
> > arm64 are as follows. This test derived from the result of command
> > 'chronyc sources'. we should take more care of the last sample column
> > which shows the offset between the local clock and the source at the last
> measurement.
> >
> > no kvm ptp in guest:
> > MS Name/IP address   Stratum Poll Reach LastRx Last sample
> >
> ==========================================================
> ==============
> > ^* dns1.synet.edu.cn      2   6   377    13  +1040us[+1581us] +/-   21ms
> > ^* dns1.synet.edu.cn      2   6   377    21  +1040us[+1581us] +/-   21ms
> > ^* dns1.synet.edu.cn      2   6   377    29  +1040us[+1581us] +/-   21ms
> > ^* dns1.synet.edu.cn      2   6   377    37  +1040us[+1581us] +/-   21ms
> > ^* dns1.synet.edu.cn      2   6   377    45  +1040us[+1581us] +/-   21ms
> > ^* dns1.synet.edu.cn      2   6   377    53  +1040us[+1581us] +/-   21ms
> > ^* dns1.synet.edu.cn      2   6   377    61  +1040us[+1581us] +/-   21ms
> > ^* dns1.synet.edu.cn      2   6   377     4   -130us[ +796us] +/-   21ms
> > ^* dns1.synet.edu.cn      2   6   377    12   -130us[ +796us] +/-   21ms
> > ^* dns1.synet.edu.cn      2   6   377    20   -130us[ +796us] +/-   21ms
> >
> > in host:
> > MS Name/IP address   Stratum Poll Reach LastRx Last sample
> >
> ==========================================================
> ==============
> > ^* 120.25.115.20          2   7   377    72   -470us[ -603us] +/-   18ms
> > ^* 120.25.115.20          2   7   377    92   -470us[ -603us] +/-   18ms
> > ^* 120.25.115.20          2   7   377   112   -470us[ -603us] +/-   18ms
> > ^* 120.25.115.20          2   7   377     2   +872ns[-6808ns] +/-   17ms
> > ^* 120.25.115.20          2   7   377    22   +872ns[-6808ns] +/-   17ms
> > ^* 120.25.115.20          2   7   377    43   +872ns[-6808ns] +/-   17ms
> > ^* 120.25.115.20          2   7   377    63   +872ns[-6808ns] +/-   17ms
> > ^* 120.25.115.20          2   7   377    83   +872ns[-6808ns] +/-   17ms
> > ^* 120.25.115.20          2   7   377   103   +872ns[-6808ns] +/-   17ms
> > ^* 120.25.115.20          2   7   377   123   +872ns[-6808ns] +/-   17ms
> >
> > The dns1.synet.edu.cn is the network reference clock for guest and
> > 120.25.115.20 is the network reference clock for host. we can't get
> > the clock error between guest and host directly, but a roughly
> > estimated value will be in order of hundreds of us to ms.
> >
> > with kvm ptp in guest:
> > chrony has been disabled in host to remove the disturb by network clock.
> >
> > MS Name/IP address         Stratum Poll Reach LastRx Last sample
> >
> ==========================================================
> ==============
> > * PHC0                    0   3   377     8     -7ns[   +1ns] +/-    3ns
> > * PHC0                    0   3   377     8     +1ns[  +16ns] +/-    3ns
> > * PHC0                    0   3   377     6     -4ns[   -0ns] +/-    6ns
> > * PHC0                    0   3   377     6     -8ns[  -12ns] +/-    5ns
> > * PHC0                    0   3   377     5     +2ns[   +4ns] +/-    4ns
> > * PHC0                    0   3   377    13     +2ns[   +4ns] +/-    4ns
> > * PHC0                    0   3   377    12     -4ns[   -6ns] +/-    4ns
> > * PHC0                    0   3   377    11     -8ns[  -11ns] +/-    6ns
> > * PHC0                    0   3   377    10    -14ns[  -20ns] +/-    4ns
> > * PHC0                    0   3   377     8     +4ns[   +5ns] +/-    4ns
> >
> > The PHC0 is the ptp clock which choose the host clock as its source
> > clock. So we can see that the clock difference between host and guest
> > is in order of ns.
> >
> > Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> > ---
> >  drivers/clocksource/arm_arch_timer.c | 24 +++++++++++++
> >  drivers/ptp/Kconfig                  |  2 +-
> >  drivers/ptp/ptp_kvm_arm64.c          | 53
> ++++++++++++++++++++++++++++
> >  3 files changed, 78 insertions(+), 1 deletion(-)  create mode 100644
> > drivers/ptp/ptp_kvm_arm64.c
> >
> > diff --git a/drivers/clocksource/arm_arch_timer.c
> > b/drivers/clocksource/arm_arch_timer.c
> > index d55acffb0b90..aaf286e90092 100644
> > --- a/drivers/clocksource/arm_arch_timer.c
> > +++ b/drivers/clocksource/arm_arch_timer.c
> > @@ -1650,3 +1650,27 @@ static int __init arch_timer_acpi_init(struct
> > acpi_table_header *table)  }  TIMER_ACPI_DECLARE(arch_timer,
> > ACPI_SIG_GTDT, arch_timer_acpi_init);  #endif
> > +
> > +#if IS_ENABLED(CONFIG_PTP_1588_CLOCK_KVM)
> > +#include <linux/arm-smccc.h>
> > +int kvm_arch_ptp_get_crosststamp(unsigned long *cycle, struct
> timespec64 *ts,
> > +			      struct clocksource **cs)
> > +{
> > +	struct arm_smccc_res hvc_res;
> > +	ktime_t ktime;
> > +
> > +	/* Currently, linux guest will always use the virtual counter */
> > +
> 	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_PTP_FU
> NC_ID,
> > +			     ARM_PTP_VIRT_COUNTER, &hvc_res);
> > +	if ((long long)(hvc_res.a0) < 0)
> > +		return -EOPNOTSUPP;
> > +
> > +	ktime = (long long)hvc_res.a0;
> > +	*ts = ktime_to_timespec64(ktime);
> > +	*cycle = (long long)hvc_res.a1;
> > +	*cs = &clocksource_counter;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(kvm_arch_ptp_get_crosststamp);
> > +#endif
> > diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig index
> > 942f72d8151d..127e96f14f89 100644
> > --- a/drivers/ptp/Kconfig
> > +++ b/drivers/ptp/Kconfig
> > @@ -106,7 +106,7 @@ config PTP_1588_CLOCK_PCH  config
> > PTP_1588_CLOCK_KVM
> >  	tristate "KVM virtual PTP clock"
> >  	depends on PTP_1588_CLOCK
> > -	depends on KVM_GUEST && X86
> > +	depends on KVM_GUEST && X86 || ARM64 && ARM_ARCH_TIMER
> &&
> > +ARM_PSCI_FW
> >  	default y
> >  	help
> >  	  This driver adds support for using kvm infrastructure as a PTP
> > diff --git a/drivers/ptp/ptp_kvm_arm64.c b/drivers/ptp/ptp_kvm_arm64.c
> > new file mode 100644 index 000000000000..961abed93dfd
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
> 	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_FEATUR
> ES_FUNC_ID,
> > +			     &hvc_res);
> > +	if (!(hvc_res.a0 | BIT(ARM_SMCCC_KVM_FUNC_KVM_PTP)))
> > +		return -EOPNOTSUPP;
> > +
> > +	return 0;
> 
> What happens if the
> ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID function isn't
> implemented (on an old kernel or a non-KVM hypervisor)? The expected
> behaviour is that a0 will contain SMCCC_RET_NOT_SUPPORTED, which is -1.
> The result is that this function always returns "supported". Not an acceptable
> behaviour.
> 
Oh!  it's really a stupid mistake, should be "&" not "|".

> > +}
> > +
> > +int kvm_arch_ptp_get_clock_generic(struct timespec64 *ts,
> > +				   struct arm_smccc_res *hvc_res)
> 
> Why isn't this static?
>
 yeah, should be static.

> > +{
> > +	ktime_t ktime;
> > +
> > +
> 	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_PTP_FU
> NC_ID,
> > +			     hvc_res);
> > +	if ((long long)(hvc_res->a0) < 0)
> > +		return -EOPNOTSUPP;
> 
> Really? What if the cycle counter is a full 64 bit value, as it is
> *mandated* on ARMv8.6? It means that the counter is now invalid for half
> the lifetime of the system. Not acceptable either.
> 
> > +
> > +	ktime = (long long)hvc_res->a0;
> > +	*ts = ktime_to_timespec64(ktime);
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
> > --
> > 2.17.1
> >
> >
> 
> It is now obvious that the API between kernel and hypervisor is pretty
> busted, and it goes beyond the 32bit support. I wish you paid more attention
> to this kind of detail.

Yeah,  I will.

Thanks
Jianyong 
> 
> 	M.
> 
> --
> Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
