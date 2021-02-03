Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AB93530DEEC
	for <lists+kvmarm@lfdr.de>; Wed,  3 Feb 2021 16:58:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 414134B290;
	Wed,  3 Feb 2021 10:58:42 -0500 (EST)
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
	with ESMTP id tnOiFGzW-B5B; Wed,  3 Feb 2021 10:58:42 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4865E4B281;
	Wed,  3 Feb 2021 10:58:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D6C74B246
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Feb 2021 10:58:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gcWlAtb3YgYd for <kvmarm@lists.cs.columbia.edu>;
 Wed,  3 Feb 2021 10:58:39 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 441BB4B241
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Feb 2021 10:58:39 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3128164F65;
 Wed,  3 Feb 2021 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612367918;
 bh=K59+ysyzksVMwJO4K3IQGFBLA+vh5P1R5hVr7mhTX0o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fM7SFqDXMg/QLD8TWNvrnoM5MjHuJjnK5+czbDxVPpQB7YFw6x0QPXxQ7Rxb8F1kR
 gVZZp6gb+Jnnox8hFopqCHQGf2p2xvojEklQbWbZVDwsS9KNh9l/WhH16A5O37/pIu
 vrfBENpdvL7uvuFTjd3v3R36n1YJC2wnpv4iENRHC/FHtn1RzpqEwqn5sqfT2HDK6k
 eo5sHlz4fLAbf6h9gS1f8+RvlLyKufY9XU8svoGJrDDSiQurtaNJJWJGCtF6GWZF7E
 4cLwALUvcsouJrBAYugYyQNh67aXO1q8FVVTQP9RvvOtaaYB2ROzch5Ww7Johcnn6/
 /P9PkrZVj2/Ww==
Date: Wed, 3 Feb 2021 15:58:32 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [RFC PATCH v2 23/26] KVM: arm64: Refactor __populate_fault_info()
Message-ID: <20210203155831.GG18974@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-24-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-24-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, kernel-team@android.com, android-kvm@google.com,
 Catalin Marinas <catalin.marinas@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, kvmarm@lists.cs.columbia.edu
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

On Fri, Jan 08, 2021 at 12:15:21PM +0000, Quentin Perret wrote:
> Refactor __populate_fault_info() to introduce __get_fault_info() which
> will be used once the host is wrapped in a stage 2.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 36 +++++++++++++++----------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index 84473574c2e7..e9005255d639 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -157,19 +157,9 @@ static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
>  	return true;
>  }
>  
> -static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
> +static inline bool __get_fault_info(u64 esr, u64 *far, u64 *hpfar)

Could this take a pointer to a struct kvm_vcpu_fault_info instead?

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
