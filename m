Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9832F9DB7
	for <lists+kvmarm@lfdr.de>; Mon, 18 Jan 2021 12:13:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D28254B276;
	Mon, 18 Jan 2021 06:13:47 -0500 (EST)
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
	with ESMTP id ZSZ3ONzbvV0q; Mon, 18 Jan 2021 06:13:47 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC10F4B275;
	Mon, 18 Jan 2021 06:13:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 79D184B270
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Jan 2021 06:13:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id On6gTczei6S7 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 18 Jan 2021 06:13:44 -0500 (EST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5040A4B254
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Jan 2021 06:13:44 -0500 (EST)
Received: by mail-wm1-f44.google.com with SMTP id g10so13424055wmh.2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Jan 2021 03:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=fLMG4vsTzbqzDa7NYZTtEssmDNdJhpiTjSVtjAKlEtA=;
 b=bYq5xCIxzjmV299kxFOaCiB/AS3jxa624Jqc6YIZmywPF0VJLTMwG3jbAp3Rl307/k
 hbfiB4H9mXbxETPI4v+GT1gwFHDX70mGRsQar2IpJ2FKIAKHJvFWzRMFchybki6gBfPB
 6p7Z5e/42vPSZqedt7jpJtu9+gZwqSj8cfxt/JH2KRt19eCGYArh3kvHtA9a7qRIRLL8
 b+nazIab6dctS0iZyKhVbpkE8mb0EMfLHaKpgyBxCulmhIYnf5VVvq5LCDBvM/gkb6AL
 2M3nAOmJjcBr9iah49+H/XndkzN8NpGh9ij+ij8wEH6swOnsfecHixfdPAc94g17XTIC
 z6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fLMG4vsTzbqzDa7NYZTtEssmDNdJhpiTjSVtjAKlEtA=;
 b=tFg5z6+33oxBYgjU8+y/+eQ/dUfODkpzGxQn1pvzWm4e1qpMPOi8NG4K1mIuPcrYde
 6atFZdNKc4pEIAzSol+yeQuzhXqwZH2Fq6szWQZPbGt4v7btXpXyC+Z2Yakjt7x769HQ
 ftT4Bnl9LwQa6FOEk294T2yQhvxdCZguTw2JmpfC83HlMmLoUAwePz/vePV6nNoEYYWd
 AiQiaWz1eVYbfpLRyH06uWOhqRABM9TeOkMKfzsRWNolcdqNsgZB/amfFqbQzhvve7t6
 iexii2z9dYjtb/nkEwcy7OZ89GPfY4DNw1vyBqpvd+bGEMnT1d+55wdonovmXTa8wFxQ
 tLtA==
X-Gm-Message-State: AOAM531Z0enHZSidh1elzjiCxk1XTN1s5/3zyQCbhn93GHuDlw60cyF5
 xBvSMXaOyHwa0omseIjCwpAkXw==
X-Google-Smtp-Source: ABdhPJzf9c0SbOFn9Oq6MnmHnjRdRnsDCTN+qFk/yY+z+IA/dnEfzlcf743XMJ3WHiVu6gPS86334Q==
X-Received: by 2002:a1c:e055:: with SMTP id x82mr19724434wmg.185.1610968423194; 
 Mon, 18 Jan 2021 03:13:43 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:3d4d:985d:87b7:4d55])
 by smtp.gmail.com with ESMTPSA id b7sm28398175wrv.47.2021.01.18.03.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 03:13:42 -0800 (PST)
Date: Mon, 18 Jan 2021 11:13:41 +0000
From: David Brazdil <dbrazdil@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 01/21] arm64: Fix labels in el2_setup macros
Message-ID: <20210118111341.porgvi56bzqlt36v@google.com>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-2-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-2-maz@kernel.org>
Cc: kernel-team@android.com, Srinivas Ramana <sramana@codeaurora.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Ajay Patil <pajay@qti.qualcomm.com>,
 Prasad Sodagudi <psodagud@codeaurora.org>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Mon, Jan 18, 2021 at 09:45:13AM +0000, Marc Zyngier wrote:
> If someone happens to write the following code:
> 
> 	b	1f
> 	init_el2_state	vhe
> 1:
> 	[...]
> 
> they will be in for a long debugging session, as the label "1f"
> will be resolved *inside* the init_el2_state macro instead of
> after it. Not really what one expects.
> 
> Instead, rewite the EL2 setup macros to use unambiguous labels,
> thanks to the usual macro counter trick.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/el2_setup.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Acked-by: David Brazdil <dbrazdil@google.com>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
