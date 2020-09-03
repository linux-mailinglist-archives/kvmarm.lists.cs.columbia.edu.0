Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 52E8125C0D1
	for <lists+kvmarm@lfdr.de>; Thu,  3 Sep 2020 14:17:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BC5374B252;
	Thu,  3 Sep 2020 08:17:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q2hAwvvi63oD; Thu,  3 Sep 2020 08:17:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4F4284B238;
	Thu,  3 Sep 2020 08:17:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 165744B22C
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 08:17:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ec7jmJNnLCln for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Sep 2020 08:16:58 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 08AA24B218
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 08:16:58 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2A48D20678;
 Thu,  3 Sep 2020 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599135416;
 bh=8zfNfq9GQ4goV2fTuV/qtoUzH7+9MEGpFO1ipmzAXtc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ikTTeu8F5pk921TfM0iOxm2WJ/XBy5IGnpjuEmENPA2ZrHNLmKmof1/a6gz7A9DyN
 vrdNccpUgudk/REVhzqRu9wxR1M0TF5QARnDkma9ksY6w3M2h//dAP0JXeHgyaH3X4
 sSv2O1M5qoBrFqgk24drjEXXuhEjFyniJdMwyGus=
Date: Thu, 3 Sep 2020 13:16:51 +0100
From: Will Deacon <will@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 00/21] KVM: arm64: Rewrite page-table code and fault
 handling
Message-ID: <20200903121651.GA7412@willie-the-truck>
References: <20200825093953.26493-1-will@kernel.org>
 <f7e20f9c-e14e-5314-f78f-1d73743da84c@redhat.com>
 <3f13fc6e-7234-6c53-cfaa-a5052fcabe6d@redhat.com>
 <29ec59b6-ca36-1bd0-0d19-097ecb999bb2@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <29ec59b6-ca36-1bd0-0d19-097ecb999bb2@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Thu, Sep 03, 2020 at 09:48:18PM +1000, Gavin Shan wrote:
> On 9/3/20 9:13 PM, Gavin Shan wrote:
> > On 9/3/20 5:34 PM, Gavin Shan wrote:
> > > On 8/25/20 7:39 PM, Will Deacon wrote:
> > > > Hello folks,
> > > > =

> > > > This is version three of the KVM page-table rework that I previousl=
y posted
> > > > here:
> > > > =

> > > > =A0=A0 v1: https://lore.kernel.org/r/20200730153406.25136-1-will@ke=
rnel.org
> > > > =A0=A0 v2: https://lore.kernel.org/r/20200818132818.16065-1-will@ke=
rnel.org
> > > > =

> > > > Changes since v2 include:
> > > > =

> > > > =A0=A0 * Rebased onto -rc2, which includes the conflicting OOM bloc=
king fixes
> > > > =A0=A0 * Dropped the patch trying to "fix" the memcache in kvm_phys=
_addr_ioremap()
> > > > =

> > > =

> > > It's really nice work, making the code unified/simplified greatly.
> > > However, it seems it doesn't work well with HugeTLBfs. Please refer
> > > to the following test result and see if you have quick idea, or I
> > > can debug it a bit :)

Nice testing matrix, and thanks for reporting the problem!

> > > Machine=A0=A0=A0=A0=A0=A0=A0=A0 Host=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Guest=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Re=
sult
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > ThunderX2=A0=A0=A0 VA_BITS:=A0=A0 42=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PA=
GE_SIZE:=A0 4KB=A0=A0=A0=A0 Passed
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PAGE_SIZE: 64KB=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 64KB=A0=A0=A0=A0 passed
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 THP:=A0=A0=A0=A0=A0=A0 disabl=
ed
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 HugeTLB:=A0=A0 disabled
> > > ---------------------------------------------------------------
> > > ThunderX2=A0=A0=A0 VA_BITS:=A0=A0 42=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PA=
GE_SIZE:=A0 4KB=A0=A0=A0=A0 Passed
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PAGE_SIZE: 64KB=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 64KB=A0=A0=A0=A0 passed
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 THP:=A0=A0=A0=A0=A0=A0 enabled
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 HugeTLB:=A0=A0 disabled
> > > ----------------------------------------------------------------
> > > ThunderX2=A0=A0=A0 VA_BITS:=A0=A0 42=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PA=
GE_SIZE:=A0 4KB=A0=A0=A0=A0 Fail[1]
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PAGE_SIZE: 64KB=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 64KB=A0=A0=A0=A0 Fail[1]
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 THP:=A0=A0=A0=A0=A0=A0 disabl=
ed
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 HugeTLB:=A0=A0 enabled
> > > ---------------------------------------------------------------
> > > ThunderX2=A0=A0=A0 VA_BITS:=A0=A0 39=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PA=
GE_SIZE:=A0 4KB=A0=A0=A0=A0 Passed
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PAGE_SIZE: 4KB=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 64KB=A0=A0=A0=A0 Passed
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 THP:=A0=A0=A0=A0=A0=A0 disabl=
ed
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 HugeTLB:=A0=A0 disabled
> > > ---------------------------------------------------------------
> > > ThunderX2=A0=A0=A0 VA_BITS:=A0=A0 39=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PA=
GE_SIZE:=A0 4KB=A0=A0=A0=A0 Passed
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PAGE_SIZE: 4KB=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 64KB=A0=A0=A0=A0 Passed
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 THP:=A0=A0=A0=A0=A0=A0 enabled
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 HugeTLB:=A0=A0 disabled
> > > --------------------------------------------------------------
> > > ThunderX2=A0=A0=A0 VA_BITS:=A0=A0 39=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PA=
GE_SIZE: 4KB=A0=A0=A0=A0 Fail[2]
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PAGE_SIZE: 4KB=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 64KB=A0=A0=A0=A0 Fail[2]
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 THP:=A0=A0=A0=A0=A0=A0 disabl=
ed
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 HugeTLB:=A0=A0 enabled
> > > =

> > =

> > I debugged the code and found the issue is caused by the following
> > patch.
> > =

> > [PATCH v3 06/21] KVM: arm64: Add support for stage-2 map()/unmap() in g=
eneric page-table

(I think this is just a symptom of the page-table being out of whack)

> Sorry that the guest could hang sometimes with above changes. I have no i=
dea what
> has been happening before I'm going to debug for more.. I'm pasting the u=
sed command
> and output from guest.

Can you try the diff below, please? I think we can end up sticking down a
huge-page-sized mapping at an unaligned address, which causes us both to
overmap and also to fail to use the huge granule for a block mapping.

Cheers,

Will

--->8

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index f28e03dcb897..3bff942e5f33 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -737,11 +737,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys=
_addr_t fault_ipa,
        bool exec_fault;
        bool device =3D false;
        unsigned long mmu_seq;
-       gfn_t gfn =3D fault_ipa >> PAGE_SHIFT;
        struct kvm *kvm =3D vcpu->kvm;
        struct kvm_mmu_memory_cache *memcache =3D &vcpu->arch.mmu_page_cach=
e;
        struct vm_area_struct *vma;
        short vma_shift;
+       gfn_t gfn;
        kvm_pfn_t pfn;
        bool logging_active =3D memslot_is_logging(memslot);
        unsigned long vma_pagesize;
@@ -780,7 +780,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_a=
ddr_t fault_ipa,
        }
 =

        if (vma_pagesize =3D=3D PMD_SIZE || vma_pagesize =3D=3D PUD_SIZE)
-               gfn =3D (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PA=
GE_SHIFT;
+               fault_ipa &=3D huge_page_mask(hstate_vma(vma));
+
+       gfn =3D fault_ipa >> PAGE_SHIFT;
        mmap_read_unlock(current->mm);
 =

        if (fault_status !=3D FSC_PERM) {

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
