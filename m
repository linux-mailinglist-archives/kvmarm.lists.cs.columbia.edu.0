Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CFF0F2B90B5
	for <lists+kvmarm@lfdr.de>; Thu, 19 Nov 2020 12:15:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B6344B483;
	Thu, 19 Nov 2020 06:15:01 -0500 (EST)
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
	with ESMTP id BAr5IJd4Ez9j; Thu, 19 Nov 2020 06:15:01 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 46F374B484;
	Thu, 19 Nov 2020 06:15:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D5224B32C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Nov 2020 06:14:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VAMApbX2OMQV for <kvmarm@lists.cs.columbia.edu>;
 Thu, 19 Nov 2020 06:14:57 -0500 (EST)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D04214B32F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Nov 2020 06:14:57 -0500 (EST)
Received: by mail-wm1-f68.google.com with SMTP id w24so6390930wmi.0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Nov 2020 03:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AT6vz2m42JXc7lrJwjmpvEMB8s7HSthxy8G6z45TFw8=;
 b=uyZKU41rSPFAFtLcohcLT9M2PYocUNVHWJWTf53IFCaNw7mcYBQ/OV5mF+Z9pUbtfJ
 pdGu30hiumiwL19aJe2aDPkmVcdpTz5KoWexqw70c9y9oBC49pNNsde7osvyz+XO6v51
 rxLO0OtV9yAmrJsEQRwQduDZyGZzh0/tJXDAFuP3Dkx3uNnotD3KgqM5ZYL58mtpgG8g
 41MOobefny3kFsPuCQY7AYFsMiN7wk2fscZESRIZd6slXTGiOo3U6S/OMJU8YKhwc1eO
 +mcuricEPz+YrRLiUnP9AvGQ/imaM0YwAZgi92o8A7PM6dcH1Gq5syyb3fl9WETdoAlZ
 Scaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AT6vz2m42JXc7lrJwjmpvEMB8s7HSthxy8G6z45TFw8=;
 b=giEvwzLVFFWRRB+om444LvjCFrsg9QGe5IbhTarIDwthlZcPjzxJ0agVcS1sugNdeQ
 zUal8QfJIHYr1xZ8CxjyF8bAMGkw71S7Q19qcCeuwqV9zijuMC8lXYuzQp0Y3Oyc76bi
 AGGlsZZ5f+1zrovIMvn/8a082de/New3+SeuMyhptFdCgWfr0obpRO7l0OmMhZICWygW
 zLaveDNhAoxSZw47dXjqY8IGIbdTH4A+ziCYXO9XVVhOpvbFpp/95kvDNxCCcbu6pLAF
 VkagDKcyVpd5UXKyvKH8fXj+s8g063kaLl9JPWbA9V9+Y4LFnMzwyJRSwGQWMeEJuLUS
 sUeA==
X-Gm-Message-State: AOAM530gKi6tnYxWTXkmWGSPH06qlw9KAk5tDCUbSKF94HxTLqtOwq/F
 Jn2lf3MCpIoH1W8Xi+dxeTIhtQ==
X-Google-Smtp-Source: ABdhPJyhjWDduxIBws3Ul6EHk3OG2nFzeTTtIhTcNveUaPVZ7P2RuGx59RiEB/hStDd4b5hulEmX3w==
X-Received: by 2002:a1c:7704:: with SMTP id t4mr4065727wmi.48.1605784496615;
 Thu, 19 Nov 2020 03:14:56 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:9843:cd3f:f36b:d55c])
 by smtp.gmail.com with ESMTPSA id b124sm9245409wmh.13.2020.11.19.03.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2020 03:14:55 -0800 (PST)
Date: Thu, 19 Nov 2020 11:14:54 +0000
From: David Brazdil <dbrazdil@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 3/5] KVM: arm64: Patch kimage_voffset instead of
 loading the EL1 value
Message-ID: <20201119111454.vrbogriragp7zukk@google.com>
References: <20201109175923.445945-1-maz@kernel.org>
 <20201109175923.445945-4-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201109175923.445945-4-maz@kernel.org>
Cc: kernel-team@android.com, kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 ndesaulniers@google.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
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

Hey Marc,

Just noticed in kvmarm/queue that the whitespacing in this patch is off.

> +.macro kimg_pa reg, tmp
> +alternative_cb kvm_get_kimage_voffset
> +       movz    \tmp, #0
> +       movk    \tmp, #0, lsl #16
> +       movk    \tmp, #0, lsl #32
> +       movk    \tmp, #0, lsl #48
> +alternative_cb_end
> +
> +       /* reg = __pa(reg) */
> +       sub     \reg, \reg, \tmp
> +.endm
This uses spaces instead of tabs.

> +	 
>  #else
This added empty line actually has a tab in it.

-David
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
