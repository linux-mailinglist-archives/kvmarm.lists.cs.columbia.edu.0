Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 78888B4615
	for <lists+kvmarm@lfdr.de>; Tue, 17 Sep 2019 05:43:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B24A4A68C;
	Mon, 16 Sep 2019 23:43:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@wdc.com
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@sharedspace.onmicrosoft.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UwcGKQH7Fu+0; Mon, 16 Sep 2019 23:43:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 161C44A67B;
	Mon, 16 Sep 2019 23:43:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D6F14A5C6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Sep 2019 23:43:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ohB04VkKDSnD for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Sep 2019 23:42:59 -0400 (EDT)
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2DBCF4A5CB
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Sep 2019 23:42:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568691780; x=1600227780;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Xcjh1P+oVyrEI0Mdp5T33DCcbiXymp+pK9SMl4Otr2A=;
 b=nrqz6zj9CjOl/orxSMEwVQfNDxN+Mn9HjEVl5Je3RhMO0b+ZSBYaEI4t
 ruI5t+XvSwcLDOoymIKbq4JXS7jw2haoeEx7hDOtn/hJkYMRLfTRyoBn9
 uti+EDPkdufHEpdHPGWPKKqC+h9TDeJu7ia3r+YRMnCGQr7xvyR9gGOzZ
 Avb/rQkHAEO8oFNWtOyqrhxAoXEg7rlAmViSjjCHof2dG3GQ/nrUSUnDX
 5vfNpSr0DK5M0K+6dzMheufxg0CH7oUqwtQ5e0G2Tt1uYUKoOVY5aMQuK
 Um2y+CzxaDbR8sQUIsOJInvB6wzLp8K4HNvBY3Zz9dp0YrVzflItq8+Yr w==;
IronPort-SDR: ZtUhlEYPXv9L5UvQ9q0qq145WxggWqP4CdMvo8BNdw8shzkblNGfjgpCFwAcVpQC+zDjU5ow8b
 HYV+D9WvTZEyX8uMPF2ISy0w2BMxLBaV/ewmra1ccTUjorXbukstAQK4jeKtRU0w1wpjzi0c1C
 e19rYwYUbegLpikp+dXSDuxcFHYhjoKRSubWG2A+AOnGuxGkKrIuqwDPozJxt2SO3Fency6HkX
 iDa5qzs3Xw3WEOQEo/dQoe08gTSUJFWJwD7hPAygzTKiDyBw9LZG5cNFZk0w7PEmtGaj6eV0KK
 vmM=
X-IronPort-AV: E=Sophos;i="5.64,515,1559491200"; d="scan'208";a="119240196"
Received: from mail-sn1nam02lp2059.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.59])
 by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2019 11:42:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8xp5hTqoeVIfrkYnLxx6Hq+nA6s36ReqWPStrq/6g9k4bOFpmy4NTCtH8YsvgiDYeoWb2y9fWe2tQ39FbMfRH06Nvg9F5uVz3at7p6wqbvswn0jH1pz09nG9l0B4dnc/kFjLRLRsjFijb3f4Dd5uLswBda+C9+iVBXGJeMGSOwGB/2KqqcTGaC6mGVqN3VsKiIZRP/QPATjQZ3ZmcD+1KiLn9A0XE70cSIYnoFYQpD2gqhjjO7jsqCM+M7scGfw5tsbqD2GM7ccJKYj6Bit3EZ/9Dsn8qG63FpNJQuT6cfWMWgq+Yn74nEMShuq0i0cOYs5LerYLJghGjd+PHQkGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xcjh1P+oVyrEI0Mdp5T33DCcbiXymp+pK9SMl4Otr2A=;
 b=hZ/cJ9uLAoaraQWDfR1ywxelHGUsDcDBCkvU7+H/Pcoe2dUb8ZM16EiSy9YGuvLZJdU1BolE5Z9bqXAtQ1nUZ8chlsqgHqTXZf8rlX6V/zgGQz6S3qb2mGMRAXVC7FjGtkgcnKjpgN9xYiuQhaSxBwDyuv43GCa1NmrsqIVvZh9sQ4/PQEY8QNDIWV+VnWIYy8EdG9B95UdQ3Is4iaGaIscUeYE13PMtsmhudEIeGkAE7fBMwSYyJptoZeP+36j4UVyQqWF8QP4a+nIfAiSQjKHGF9lfvb+V0z725SVdH4PWtOIcCSzt0mnGZy0cb80qhWMujRPn6IT/FqLPv/G2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xcjh1P+oVyrEI0Mdp5T33DCcbiXymp+pK9SMl4Otr2A=;
 b=TY0LO+mQBx799M9z/3dGdT3ZksyARpE9JHkZVvkg5z8dU8xAuaCgUPJz1x1RYj5JVS/tb8HGloAYirBnQRG8VDHeDvCfclr1SsfdgBgPodsOgcGasEH4sAnEmOjpMCH4VGGdLCq+GKnrHA5bbDeNBtkNmfeb9+BQ0/GRv1Jw7lM=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6782.namprd04.prod.outlook.com (10.186.144.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Tue, 17 Sep 2019 03:42:54 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 03:42:54 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Will Deacon <will@kernel.org>
Subject: RE: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
Thread-Topic: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
Thread-Index: AQHU4ARW4cwQ4eGTBkiNSNBcx5My8aaNvxWAgBVs3wCAAA0vgIAABQWAgAAz5gCAAAYHgIABXjKAgAZcEYCAdrxbgIAHNtEAgAMkQoCAAPtQ0IACcQYAgACaYaA=
Date: Tue, 17 Sep 2019 03:42:54 +0000
Message-ID: <MN2PR04MB60612846CD50ED157DE5AB548D8F0@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <20190912140256.fwbutgmadpjbjnab@willie-the-truck>
 <mhng-166dcd4f-9483-4aab-a83a-914d70ddb5a4@palmer-si-x1e>
 <MN2PR04MB606117F2AC47385EF23D267D8D8D0@MN2PR04MB6061.namprd04.prod.outlook.com>
 <20190916181800.7lfpt3t627byoomt@willie-the-truck>
In-Reply-To: <20190916181800.7lfpt3t627byoomt@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b6397c5-65af-4473-1566-08d73b211f5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:MN2PR04MB6782; 
x-ms-traffictypediagnostic: MN2PR04MB6782:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6782B59C8CE6853D4D4CF8D58D8F0@MN2PR04MB6782.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(13464003)(64756008)(66446008)(66556008)(26005)(52536014)(229853002)(476003)(53546011)(74316002)(6916009)(6506007)(76176011)(33656002)(99286004)(71190400001)(446003)(305945005)(186003)(7736002)(486006)(6116002)(102836004)(6246003)(3846002)(11346002)(71200400001)(4326008)(316002)(54906003)(14454004)(81166006)(8936002)(66476007)(81156014)(5660300002)(8676002)(66066001)(9686003)(256004)(6306002)(14444005)(7416002)(55016002)(86362001)(966005)(66946007)(76116006)(478600001)(2906002)(7696005)(25786009)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6782;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8fnNTNGtiHThKagqoifvZfCUozbdUSEcs1Ux4bXE4LiYIX+FXbXOaGnLJWPr6gGeWCAgk+OAgAjFUaREejMKcemLj+2I5j4NAlNf6K1iWMtZA9t7/aKL35OGwsK3pXxEv3iQ5lQm2DX/HmcolCNDyHoF2nJr2cVFGllnqPgKeyNsa9cMNbyj/FZVowXvGso9Y1YAxxnM0Sb7Z1LWe/PjjqBQUwi95Uqw9D+WahPj47+mz/mhvfV24SLGXvFILjD5fR1JF/XfB7yAq5clq7MCaXGHbEZ8dj6vQURFu6H2xQQPB4ZBNMEJwksvxOZ1Q5m9ZgYofRj1efMpnJ7slXs607uyEz3+IUirU6n8qenh+byEKsZRURaSrdeYjERylu8spiz84FLJg0+7ZOy1CcbIwdLD3FFRav3yKtIf7sO5WLc=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6397c5-65af-4473-1566-08d73b211f5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 03:42:54.0874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jB61ouXmKe8AuGKg04FYsLgrbmyPqL1z+OmwYdbUaSwPdP3pju9J9JgQjo3/i+gD2J1zE4+Wgc77zQH5s/r5Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6782
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>,
 Atish Patra <Atish.Patra@wdc.com>,
 "julien.grall@arm.com" <julien.grall@arm.com>,
 "guoren@kernel.org" <guoren@kernel.org>, "gary@garyguo.net" <gary@garyguo.net>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
 Christoph Hellwig <hch@infradead.org>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Will Deacon
> Sent: Monday, September 16, 2019 11:48 PM
> To: Anup Patel <Anup.Patel@wdc.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>; guoren@kernel.org; Will Deacon
> <will.deacon@arm.com>; julien.thierry@arm.com; aou@eecs.berkeley.edu;
> james.morse@arm.com; Arnd Bergmann <arnd@arndb.de>;
> suzuki.poulose@arm.com; marc.zyngier@arm.com;
> catalin.marinas@arm.com; linux-kernel@vger.kernel.org;
> rppt@linux.ibm.com; Christoph Hellwig <hch@infradead.org>; Atish Patra
> <Atish.Patra@wdc.com>; julien.grall@arm.com; gary@garyguo.net; Paul
> Walmsley <paul.walmsley@sifive.com>; christoffer.dall@arm.com; linux-
> riscv@lists.infradead.org; kvmarm@lists.cs.columbia.edu; linux-arm-
> kernel@lists.infradead.org; iommu@lists.linux-foundation.org
> Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
> separate file
> 
> On Sun, Sep 15, 2019 at 05:03:38AM +0000, Anup Patel wrote:
> >
> >
> > > -----Original Message-----
> > > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > > owner@vger.kernel.org> On Behalf Of Palmer Dabbelt
> > > Sent: Saturday, September 14, 2019 7:31 PM
> > > To: will@kernel.org
> > > Cc: guoren@kernel.org; Will Deacon <will.deacon@arm.com>;
> > > julien.thierry@arm.com; aou@eecs.berkeley.edu;
> james.morse@arm.com;
> > > Arnd Bergmann <arnd@arndb.de>; suzuki.poulose@arm.com;
> > > marc.zyngier@arm.com; catalin.marinas@arm.com; Anup Patel
> > > <Anup.Patel@wdc.com>; linux-kernel@vger.kernel.org;
> > > rppt@linux.ibm.com; Christoph Hellwig <hch@infradead.org>; Atish
> > > Patra <Atish.Patra@wdc.com>; julien.grall@arm.com; gary@garyguo.net;
> > > Paul Walmsley <paul.walmsley@sifive.com>; christoffer.dall@arm.com;
> > > linux- riscv@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> > > linux-arm- kernel@lists.infradead.org;
> > > iommu@lists.linux-foundation.org
> > > Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code
> > > in a separate file
> > >
> > > On Thu, 12 Sep 2019 07:02:56 PDT (-0700), will@kernel.org wrote:
> > > > On Sun, Sep 08, 2019 at 07:52:55AM +0800, Guo Ren wrote:
> > > >> On Mon, Jun 24, 2019 at 6:40 PM Will Deacon <will@kernel.org>
> wrote:
> > > >> > > I'll keep my system use the same ASID for SMP + IOMMU :P
> > > >> >
> > > >> > You will want a separate allocator for that:
> > > >> >
> > > >> > https://lkml.kernel.org/r/20190610184714.6786-2-jean-philippe.b
> > > >> > ruck
> > > >> > er@arm.com
> > > >>
> > > >> Yes, it is hard to maintain ASID between IOMMU and CPUMMU or
> > > >> different system, because it's difficult to synchronize the
> > > >> IO_ASID when the CPU ASID is rollover.
> > > >> But we could still use hardware broadcast TLB invalidation
> > > >> instruction to uniformly manage the ASID and IO_ASID, or
> > > >> OTHER_ASID in
> > > our IOMMU.
> > > >
> > > > That's probably a bad idea, because you'll likely stall execution
> > > > on the CPU until the IOTLB has completed invalidation. In the case
> > > > of ATS, I think an endpoint ATC is permitted to take over a minute
> > > > to respond. In reality, I suspect the worst you'll ever see would
> > > > be in the msec range, but that's still an unacceptable period of
> > > > time to hold a
> > > CPU.
> > > >
> > > >> Welcome to join our disscusion:
> > > >> "Introduce an implementation of IOMMU in linux-riscv"
> > > >> 9 Sep 2019, 10:45 Jade-room-I&II (Corinthia Hotel Lisbon) RISC-V
> > > >> MC
> > > >
> > > > I attended this session, but it unfortunately raised many more
> > > > questions than it answered.
> > >
> > > Ya, we're a long way from figuring this out.
> >
> > For everyone's reference, here is our first attempt at RISC-V ASID allocator:
> > http://archive.lwn.net:8080/linux-kernel/20190329045111.14040-1-anup.p
> > atel@wdc.com/T/#u
> 
> With a reply stating that the patch "absolutely does not work" ;)

This patch was tested on existing HW (which does not have ASID implementation)
and tested on QEMU (which has very simplistic Implementation of ASID).

When I asked Gary Guo about way to get access to their HW (in same patch
email thread), I did not get any reply. After so many months passed, I now
doubt the his comment "absolutely does not work".

> 
> What exactly do you want people to do with that? It's an awful lot of effort to
> review this sort of stuff and given that Guo Ren is talking about sharing page
> tables between the CPU and an accelerator, maybe you're better off
> stabilising Linux for the platforms that you can actually test rather than
> getting so far ahead of yourselves that you end up with a bunch of wasted
> work on patches that probably won't get merged any time soon.

The intention of the ASID patch was to encourage RISC-V implementations
having ASID in HW and also ensure that things don't break on existing HW.

I don't see our efforts being wasted in trying to make Linux RISC-V feature
complete and encouraging more feature rich RISC-V CPUs.

Delays in merging patches are fine as long as people have something to try
on their RISC-V CPU implementations.

> 
> Seriously, they say "walk before you can run", but this is more "crawl before
> you can fly". What's the rush?
> 
> Will

Regards,
Anup
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
