Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 22A6F2657FB
	for <lists+kvmarm@lfdr.de>; Fri, 11 Sep 2020 06:19:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 744514B3BF;
	Fri, 11 Sep 2020 00:19:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dYua71beyMPq; Fri, 11 Sep 2020 00:19:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 682844B294;
	Fri, 11 Sep 2020 00:19:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D6E44B210
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 00:19:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rH7wAhitg-mR for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Sep 2020 00:19:43 -0400 (EDT)
Received: from smtprelay.hostedemail.com (smtprelay0216.hostedemail.com
 [216.40.44.216])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9EF7F4B20F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 00:19:43 -0400 (EDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id 12942837F24A;
 Fri, 11 Sep 2020 04:19:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, ,
 RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6742:6743:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12297:12438:12555:12740:12760:12895:13153:13161:13228:13229:13439:14096:14097:14181:14659:14721:21080:21433:21627:30054:30070:30091,
 0, RBL:none, CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none,
 DomainCache:0, MSF:not bulk, SPF:, MSBL:0, DNSBL:none, Custom_rules:0:0:0,
 LFtime:1, LUA_SUMMARY:none
X-HE-Tag: seat91_4d0f80d270eb
X-Filterd-Recvd-Size: 4376
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf19.hostedemail.com (Postfix) with ESMTPA;
 Fri, 11 Sep 2020 04:19:36 +0000 (UTC)
Message-ID: <f4ad706519917d493a0af32ea2da8565227cc74a.camel@perches.com>
Subject: Re: [trivial PATCH] treewide: Convert switch/case fallthrough; to
 break;
From: Joe Perches <joe@perches.com>
To: Robin Murphy <robin.murphy@arm.com>, LKML
 <linux-kernel@vger.kernel.org>,  Jiri Kosina <trivial@kernel.org>
Date: Thu, 10 Sep 2020 21:19:35 -0700
In-Reply-To: <9372456a-8dcf-2735-57a4-e126aa5df3a6@arm.com>
References: <e6387578c75736d61b2fe70d9783d91329a97eb4.camel@perches.com>
 <9372456a-8dcf-2735-57a4-e126aa5df3a6@arm.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Cc: linux-fbdev@vger.kernel.org, oss-drivers@netronome.com,
 nouveau@lists.freedesktop.org, alsa-devel <alsa-devel@alsa-project.org>,
 dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
 linux-ide@vger.kernel.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org,
 linux-i2c@vger.kernel.org, sparclinux@vger.kernel.org,
 Will Deacon <will@kernel.org>, linux-afs@lists.infradead.org,
 linux-rtc@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, dccp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, kvmarm@lists.cs.columbia.edu,
 coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org,
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org,
 linux-mmc@vger.kernel.org, Kees Cook <kees.cook@canonical.com>,
 linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-nvme@lists.infradead.org, storagedev@microchip.com,
 ceph-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Nick Desaulniers <ndesaulniers@google.com>, linux-nfs@vger.kernel.org,
 linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-sctp@vger.kernel.org, iommu@lists.linux-foundation.org,
 netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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

On Thu, 2020-09-10 at 15:21 +0100, Robin Murphy wrote:
> On 2020-09-09 21:06, Joe Perches wrote:
> > fallthrough to a separate case/default label break; isn't very readable.
> > 
> > Convert pseudo-keyword fallthrough; statements to a simple break; when
> > the next label is case or default and the only statement in the next
> > label block is break;
> > 
> > Found using:
> > 
> > $ grep-2.5.4 -rP --include=*.[ch] -n "fallthrough;(\s*(case\s+\w+|default)\s*:\s*){1,7}break;" *
> > 
> > Miscellanea:
> > 
> > o Move or coalesce a couple label blocks above a default: block.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> > 
> > Compiled allyesconfig x86-64 only.
> > A few files for other arches were not compiled.
> > 
> 
> [...]
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index c192544e874b..743db1abec40 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -3777,7 +3777,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
> >   	switch (FIELD_GET(IDR0_TTF, reg)) {
> >   	case IDR0_TTF_AARCH32_64:
> >   		smmu->ias = 40;
> > -		fallthrough;
> > +		break;
> >   	case IDR0_TTF_AARCH64:
> >   		break;
> >   	default:
> 
> I have to say I don't really agree with the readability argument for 
> this one - a fallthrough is semantically correct here, since the first 
> case is a superset of the second. It just happens that anything we would 
> do for the common subset is implicitly assumed (there are other 
> potential cases we simply haven't added support for at the moment), thus 
> the second case is currently empty.
> This change actively obfuscates that distinction.

Then perhaps comments should be added to usefully
describe the mechanisms.

	case IDR0_TTF_AARCH32_64:
		smmu->ias = 40;
		fallthrough;	/* and still do the 64 bit processing */
	case IDR0_TTF_AARCH64:
		/* Nothing specific yet */
		break;

> Robin.

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
