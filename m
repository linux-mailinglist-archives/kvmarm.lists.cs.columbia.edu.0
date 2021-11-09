Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 636A344A6EA
	for <lists+kvmarm@lfdr.de>; Tue,  9 Nov 2021 07:36:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CB42D4B212;
	Tue,  9 Nov 2021 01:36:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SkpgMxqeiijz; Tue,  9 Nov 2021 01:36:40 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C95E4B1FE;
	Tue,  9 Nov 2021 01:36:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 336874B192
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Nov 2021 01:36:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IpxkyxAUKfPI for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Nov 2021 01:36:37 -0500 (EST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DB3D44B18F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Nov 2021 01:36:36 -0500 (EST)
Received: by mail-pl1-f181.google.com with SMTP id p18so19065673plf.13
 for <kvmarm@lists.cs.columbia.edu>; Mon, 08 Nov 2021 22:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AATbywRIxzxNd7Dax4ALazPHnAkn6LmLQvylgIQIjyU=;
 b=FAgrJIcp9K/wuOKtdkRL4PckOjCABsXpUO4MPD5n4K5Vj1gP1nmXD/DTYI2omaAPKd
 IPEDkGcxSS26vD88hXHjuAeUq39e7y13F3jFltUBvm7RA/sKHC3qPkTB29A/IAWmTlKO
 eLvOadXS51ygn8mx16s6rdM1q3tA4dlcMxD4lxSjK+m5UG04FTIutq6Wp6re2bFU2VcF
 sa7u0zJmghqP5KTPmHXyWqWLXAG+4njMABiZ7lbA1J5bfZS2s4NdUuQhyizKTCEuQfPV
 +SCglyyaiPDFkspKrNaQqCF22eKwrNDxnfwEgdFHKjVQIAQlqRs9jiw4rW75/WWZW1q5
 Db8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AATbywRIxzxNd7Dax4ALazPHnAkn6LmLQvylgIQIjyU=;
 b=6OTNk9c70IMwfE9ALwhp+i42CincUC+L7/RV7VvqgT2vpvUkYr1jEMJdt8yKsBEhSM
 Cl0kso2baUsdTvooB7xNogyAJqdusWQ17fXcXxoMwcgNAhLxZ4MBdaAxGCg5GmUirCh1
 TIob9n9RVcc5UY6Vza8THu2in/Pbh5hL3+bYffAd0SvKTZ5IbwEcPUaVIl5dSblex6No
 F9mF/EEXpYb07ms9T8uUnKCQZjPN4TyTSQ1k/Rc7OGAiWGOe2sc+/VmLJFmwSkUSHN6S
 ibcaKVHFAdk0/dYfZBYfI3+ycvqpZdi8bnFiayeauMD37w4uBodzTQklergP+/Nv67Uy
 zjcA==
X-Gm-Message-State: AOAM533x9I6uxpYqudR+4tgklhCuGJEiahIFTTvS+o50EjLefOFjDdDF
 5ZEwI9uIqQa8Y3ow3bonhSYHnLOuvinH7o0AQX0lBg==
X-Google-Smtp-Source: ABdhPJw+hzZesb2M2vFbROCco526ACzQd7hh9Ygg7UDBQjJf0od5fbsPy4di9D+tqraqr5p9fkIf1Il82INo7scjgvk=
X-Received: by 2002:a17:90b:380d:: with SMTP id
 mq13mr4771617pjb.110.1636439795842; 
 Mon, 08 Nov 2021 22:36:35 -0800 (PST)
MIME-Version: 1.0
References: <20211104002531.1176691-1-seanjc@google.com>
 <20211104002531.1176691-9-seanjc@google.com>
In-Reply-To: <20211104002531.1176691-9-seanjc@google.com>
From: Reiji Watanabe <reijiw@google.com>
Date: Mon, 8 Nov 2021 22:36:19 -0800
Message-ID: <CAAeT=FxcFq2SoM5xRYJfB=bBzGrY1uuEUhvFd+6sb86y-rg_Yw@mail.gmail.com>
Subject: Re: [PATCH v5.5 08/30] KVM: arm64: Use "new" memslot instead of
 userspace memory region
To: Sean Christopherson <seanjc@google.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Wanpeng Li <wanpengli@tencent.com>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 linux-mips@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
 Atish Patra <atish.patra@wdc.com>, Ben Gardon <bgardon@google.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, kvmarm@lists.cs.columbia.edu,
 Janosch Frank <frankja@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Huacai Chen <chenhuacai@kernel.org>,
 linux-riscv@lists.infradead.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Albert Ou <aou@eecs.berkeley.edu>, kvm-ppc@vger.kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>, Anup Patel <anup.patel@wdc.com>,
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
 kvm-riscv@lists.infradead.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Wed, Nov 3, 2021 at 5:26 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Get the slot ID, hva, etc... from the "new" memslot instead of the
> userspace memory region when preparing/committing a memory region.  This
> will allow a future commit to drop @mem from the prepare/commit hooks
> once all architectures convert to using "new".
>
> Opportunistically wait to get the hva begin+end until after filtering out
> the DELETE case in anticipation of a future commit passing NULL for @new
> when deleting a memslot.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
