Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 628055FF055
	for <lists+kvmarm@lfdr.de>; Fri, 14 Oct 2022 16:29:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 397434B5F5;
	Fri, 14 Oct 2022 10:28:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hsDz2+7WyNea; Fri, 14 Oct 2022 10:28:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D2FAB4B2AE;
	Fri, 14 Oct 2022 10:28:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 852384B199
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Oct 2022 10:28:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YB-LUul+7BlR for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 Oct 2022 10:28:55 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1E5864B17C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Oct 2022 10:28:55 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3A83C61B6D;
 Fri, 14 Oct 2022 14:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7E1C433C1;
 Fri, 14 Oct 2022 14:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1665757733;
 bh=zX+pORsQkCidDg3PgRpxsrmwbtK10x2AqJSPcWF7yOQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=eJRrmiIO5y6iBCFj3Nzue5WtBxR5hRJOeEPRlBK7WujHLGCDe60dhiSFD3iAcWPXl
 pAUmGYDAAzZUh5QGWjze2NL2By7DOf5s2PDJcwA7UIUPVvmDBurbln9GZNklhMMEAc
 fKEiVt2kivL1sxNLWftppp3jTGUAy+dvsuxnlbgtr8CW6qCegmQWzTDrYlHlhkqT/B
 uAS+vrI3MNTN7QC5PdVaLx5GrnRWNRPM63PdDtdwBgZY/No11xmZ8Ybg3bqhFN1P4P
 CXwiMY767ktu9NFBGx7OtCpkfwgO5YrzWGjIXPZmHuECEe/yNB95mwqlMmHy8mN//I
 SCi15/Z0bD8hQ==
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1ojLgB-00GXzh-9F;
 Fri, 14 Oct 2022 15:28:51 +0100
Date: Fri, 14 Oct 2022 15:28:02 +0100
Message-ID: <87mt9yh43x.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Eric Auger <eauger@redhat.com>, Eric Ren <renzhengeek@gmail.com>
Subject: Re: [PATCH] KVM: arm64: vgic: fix wrong loop condition in
 scan_its_table()
In-Reply-To: <7f071249-b402-9534-c127-40af9379756d@redhat.com>
References: <acd9f1643980fbd27cd22523d2d84ca7c9add84a.1665592448.git.renzhengeek@gmail.com>
 <87o7ughoyf.wl-maz@kernel.org>
 <7f071249-b402-9534-c127-40af9379756d@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: eauger@redhat.com, renzhengeek@gmail.com,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, suzuki.poulose@arm.com,
 james.morse@arm.com, Alexandru.Elisei@arm.com, oliver.upton@linux.dev,
 kvmarm@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 kvmarm <kvmarm@lists.cs.columbia.edu>
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

On Thu, 13 Oct 2022 17:42:31 +0100,
Eric Auger <eauger@redhat.com> wrote:
> 
> Hi Eric,
> 
> On 10/12/22 20:33, Marc Zyngier wrote:
> > Hi Eric,
> > 
> > Before I comment on this patch, a couple of things that need
> > addressing:
> > 
> >> "Cc: marc.zyngier@arm.com, cdall@linaro.org"
> > 
> > None of these two addresses are valid anymore, and haven't been for
> > several years.
> > 
> > Please consult the MAINTAINERS file for up-to-date addresses for
> > current maintainers and reviewers, all of whom should be Cc'd on this
> > email. I've now added them as well as Eric Auger who has written most
> > of the ITS migration code, and the new mailing list (the Columbia list
> > is about to be killed).

Duh, I never CC'd the new list... Now hopefully done.

> > 
> > On Wed, 12 Oct 2022 17:59:25 +0100,
> > Eric Ren <renzhengeek@gmail.com> wrote:
> >>
> >> Reproducer hints:
> >> 1. Create ARM virt VM with pxb-pcie bus which adds
> >>    extra host bridges, with qemu command like:
> >>
> >> ```
> >>   -device pxb-pcie,bus_nr=8,id=pci.x,numa_node=0,bus=pcie.0 \
> >>   -device pcie-root-port,..,bus=pci.x \
> >>   ...
> >>   -device pxb-pcie,bus_nr=37,id=pci.y,numa_node=1,bus=pcie.0 \
> >>   -device pcie-root-port,..,bus=pci.y \
> >>   ...
> >>
> >> ```
> >> 2. Perform VM migration which calls save/restore device tables.
> >>
> >> In that setup, we get a big "offset" between 2 device_ids (
> >> one is small, another is big), which makes unsigned "len" round
> >> up a big positive number, causing loop to continue exceptionally.
> > 
> > You'll have to spell it out for me here. If you have a very sparse
> > device ID and you are only using a single level device table, you are
> > bound to have a large len. Now, is the issue that 'size' is so large
> > that it is negative as an 'int'? Describing the exact situation you're
> > in would help a lot.
> > 
> >>
> >> Signed-off-by: Eric Ren <renzhengeek@gmail.com>
> >> ---
> >>  arch/arm64/kvm/vgic/vgic-its.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
> >> index 24d7778d1ce6..673554ef02f9 100644
> >> --- a/arch/arm64/kvm/vgic/vgic-its.c
> >> +++ b/arch/arm64/kvm/vgic/vgic-its.c
> >> @@ -2141,7 +2141,7 @@ static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
> >>  			  int start_id, entry_fn_t fn, void *opaque)
> >>  {
> >>  	struct kvm *kvm = its->dev->kvm;
> >> -	unsigned long len = size;
> >> +	ssize_t len = size;
> > 
> > This feels wrong, really. If anything, all these types should be
> > unsigned, not signed. Signed types in this context make very little
> > sense...
> 
> After digging into the code back again, I realized I told you something
> wrong. The next_offset is the delta between the current device id and
> the next one. The next device can perfectly be in a different L1 device

A different L2 table, surely? By definition, we only have a single L1
table.

> table, - it is your case actually- , in which case the code is
> definitely broken.
> 
> So I guess we should rather have a
> while (true) {
> 	../..
> 	if (byte_offset >= len)
> 		break;
> 	len -= byte_offset;
> }
> 
> You can add a Fixes tag too:
> Fixes: 920a7a8fa92a ("KVM: arm64: vgic-its: Add infrastructure for table
> lookup")
> and cc stable@vger.kernel.org

Just to make it clear, do you mean this:

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 9d3299a70242..e722cafdff60 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -2162,6 +2162,9 @@ static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
 			return next_offset;
 
 		byte_offset = next_offset * esz;
+		if (byte_offset >= len)
+			break;
+
 		id += next_offset;
 		gpa += byte_offset;
 		len -= byte_offset;


If so, then I agree that this is a sensible fix. EricR, do you mind
respinning this ASAP so that I can get it merged and backported?

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
