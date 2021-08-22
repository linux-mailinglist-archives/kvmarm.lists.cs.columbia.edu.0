Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 33A9F3F4162
	for <lists+kvmarm@lfdr.de>; Sun, 22 Aug 2021 22:05:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AEEE04B22F;
	Sun, 22 Aug 2021 16:05:37 -0400 (EDT)
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
	with ESMTP id GwUOv4daCHTt; Sun, 22 Aug 2021 16:05:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ADEB94B22A;
	Sun, 22 Aug 2021 16:05:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F26DD4B21F
 for <kvmarm@lists.cs.columbia.edu>; Sun, 22 Aug 2021 16:05:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jyK4Dv7wx28s for <kvmarm@lists.cs.columbia.edu>;
 Sun, 22 Aug 2021 16:05:29 -0400 (EDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D50CB4B21C
 for <kvmarm@lists.cs.columbia.edu>; Sun, 22 Aug 2021 16:05:28 -0400 (EDT)
Received: by mail-lf1-f42.google.com with SMTP id v19so8097788lfo.7
 for <kvmarm@lists.cs.columbia.edu>; Sun, 22 Aug 2021 13:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0PEDvrbZfSicA0oIINmFafS33UuNdvbh5Yog3qCkG+4=;
 b=DidFNGmiUtjXTr1zhVXh5kDQbyb4cPPko6JsXbwUDrSTPugylFLzMyGFxza1sKm/6x
 W+wIW2kglAX+SzN0qu70kfKNHw84M60u9N9YiLoDVj7JjQBIktEi7l3A7gT4CjCOLZTX
 emni0cLuR0U8jDcpZzV4C/oa5pp86Tnknq/wkoJanv52Xswyf76AnEemcYS0ODyCC6Dz
 8R6xcMC3q2C0uMO57QDgVMm+EUT1YSwTPEmZjLdVou7dEVKMKI5TCeD7RwgS1vwqDrI5
 kuvn80tpghRu4oaK/dI1VHz4EDKnIW4cYp9DUfkbV9mMl6KbXP6GBkS3BVEEMoGdSDrq
 nSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0PEDvrbZfSicA0oIINmFafS33UuNdvbh5Yog3qCkG+4=;
 b=ANI0DumPXyhuu4B9c+APbnQQ+hwGfNrNAbmZCmJEMeHImNiuCLTe+erVIRCV6UOdQd
 QzA1692k3YCQqvZN5AOEsmp6ukdQWYvj2qGOjMCujTpdxliitRp2cvDlFHJqpC5a0loq
 GZRWSRNeBA8E90ugVRlXONrQnfUI4JgDsNFWZ4b3Dl9Z2rUuzGLd1KIZ8uLFYcpzuEQp
 y53efjCkzA4bm+B7rs2GbfsDodx1faSWitqEyJirWohvNST07BcVOmK2mBqUy+6Khf4c
 ysfdJrCkBqSGXZnj5AYp71UGLj6B4yI/JpTckbVKi0up9VfakHcDBnj5pNfcNz3FuAnj
 y2tQ==
X-Gm-Message-State: AOAM533YTbnkZ2kopytZOcX9DfdK3m6cLprnsmXZ0IUkWE3MzX66WBZA
 OFf9KBsetFDI3oNHqXddwwLR7Y2jm0h1EA+fMpOfmg==
X-Google-Smtp-Source: ABdhPJxFbnFAR0ELYP42ey3YRetfqvaG3XBGxBvuNqLbVWZhpYHrdP7/lcWuKLIhhk6P+saZLNgZNeGRTrPPcfdiZck=
X-Received: by 2002:a05:6512:3ba4:: with SMTP id
 g36mr22893893lfv.80.1629662727215; 
 Sun, 22 Aug 2021 13:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210822152526.1291918-1-maz@kernel.org>
 <20210822152526.1291918-4-maz@kernel.org>
In-Reply-To: <20210822152526.1291918-4-maz@kernel.org>
From: Oliver Upton <oupton@google.com>
Date: Sun, 22 Aug 2021 13:05:16 -0700
Message-ID: <CAOQ_QsgpgTfhDAg9Td4rgQmEy6m1j5RDDZZG9Q6UDNR3S58YLw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kvmtool: arm64: Configure VM with the minimal
 required IPA space
To: Marc Zyngier <maz@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu, Will Deacon <will@kernel.org>
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

Marc,

On Sun, Aug 22, 2021 at 8:25 AM Marc Zyngier <maz@kernel.org> wrote:
>
> There is some value in keeping the IPA space small, as it reduces
> the size of the stage-2 page tables.
>
> Let's compute the required space at VM creation time, and inform
> the kernel of our requirements.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arm/aarch64/kvm.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/arm/aarch64/kvm.c b/arm/aarch64/kvm.c
> index d03a27f2..4e66a22e 100644
> --- a/arm/aarch64/kvm.c
> +++ b/arm/aarch64/kvm.c
> @@ -3,6 +3,7 @@
>  #include <asm/image.h>
>
>  #include <linux/byteorder.h>
> +#include <kvm/util.h>
>
>  /*
>   * Return the TEXT_OFFSET value that the guest kernel expects. Note
> @@ -59,5 +60,22 @@ int kvm__arch_get_ipa_limit(struct kvm *kvm)
>
>  int kvm__get_vm_type(struct kvm *kvm)
>  {
> -       return KVM_VM_TYPE_ARM_IPA_SIZE(kvm__arch_get_ipa_limit(kvm));
> +       unsigned int ipa_bits, max_ipa_bits;
> +       unsigned long max_ipa;
> +
> +       /* If we're running on an old kernel, use 0 as the VM type */
> +       max_ipa_bits = kvm__arch_get_ipa_limit(kvm);
> +       if (!max_ipa_bits)
> +               return 0;
> +
> +       /* Otherwise, compute the minimal required IPA size */
> +       max_ipa = ARM_MEMORY_AREA + kvm->cfg.ram_size - 1;
> +       ipa_bits = max(32, fls_long(max_ipa));
> +       pr_debug("max_ipa %lx ipa_bits %d max_ipa_bits %d",
> +                max_ipa, ipa_bits, max_ipa_bits);
> +
> +       if (ipa_bits > max_ipa_bits)
> +               die("Memory too large for this system (needs %d bits, %d available)", ipa_bits, max_ipa_bits);

I imagine it may not be immediately obvious to a kvmtool user what
this log line means, like what 'bits' are being referred to here.
Would it be more helpful to report the maximum allowed memory size for
the system, as derived from the max IPA?

--
Thanks,
Oliver

> +
> +       return KVM_VM_TYPE_ARM_IPA_SIZE(ipa_bits);
>  }
> --
> 2.30.2
>
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
