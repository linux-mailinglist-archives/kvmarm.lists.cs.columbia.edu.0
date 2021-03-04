Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 019A232DA88
	for <lists+kvmarm@lfdr.de>; Thu,  4 Mar 2021 20:44:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 748C44B665;
	Thu,  4 Mar 2021 14:44:42 -0500 (EST)
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
	with ESMTP id DiwM4GWJMHZ8; Thu,  4 Mar 2021 14:44:42 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F5314B65F;
	Thu,  4 Mar 2021 14:44:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A6CE4B3A2
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Mar 2021 14:44:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BBTVVp4UEePT for <kvmarm@lists.cs.columbia.edu>;
 Thu,  4 Mar 2021 14:44:39 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 303ED4B38A
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Mar 2021 14:44:39 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A75E64F52;
 Thu,  4 Mar 2021 19:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614887078;
 bh=MCPai1ot4VOLKCgUqTHIX0hjr6qRhCdZXO2eAD7YTPA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T/ZdMeD99zLdiu5Mf8+6r1+WLZj8tYYhFIwSur1ZSlTeN2C3FD8ngHfEZ5tQjAkKS
 i/2vkYjl3E62JA/s9bOuiA9Ozuv1Bwd8eKSuUy84Y565l7dNIBRFsmJY1ko/9BI1zO
 XGygWLtIKgQ0NQ4nv8T6rPaWer/Ow0WyrBR/Ad1jrJSdYga/wXwoZrr7EVVRgghzvG
 gUOnwjnLsSzN6a+or2rPjp0N11Y3HmKgPGYJLo3ZMBCltFV5AHcnHaelWNdGQFnxw7
 CFGqNl84TaX4bqlMCfYXdymJ1liZhxR/ckgJ55j5tiiFo6hEEgAqUyRO8jhFrQ2Bl5
 rl4k0yAsojpzw==
Date: Thu, 4 Mar 2021 19:44:32 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v3 23/32] KVM: arm64: Make memcache anonymous in pgtable
 allocator
Message-ID: <20210304194431.GC21950@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-24-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-24-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: android-kvm@google.com, catalin.marinas@arm.com, mate.toth-pal@arm.com,
 seanjc@google.com, tabba@google.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

On Tue, Mar 02, 2021 at 02:59:53PM +0000, Quentin Perret wrote:
> The current stage2 page-table allocator uses a memcache to get
> pre-allocated pages when it needs any. To allow re-using this code at
> EL2 which uses a concept of memory pools, make the memcache argument of
> kvm_pgtable_stage2_map() anonymous, and let the mm_ops zalloc_page()
> callbacks use it the way they need to.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 6 +++---
>  arch/arm64/kvm/hyp/pgtable.c         | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
