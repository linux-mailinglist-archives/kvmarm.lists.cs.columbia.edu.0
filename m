Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EDA0432DA74
	for <lists+kvmarm@lfdr.de>; Thu,  4 Mar 2021 20:35:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 624C64B652;
	Thu,  4 Mar 2021 14:35:10 -0500 (EST)
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
	with ESMTP id oSjQraLmk2VO; Thu,  4 Mar 2021 14:35:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D30C4B3F0;
	Thu,  4 Mar 2021 14:35:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 15E504B349
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Mar 2021 14:35:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4mKyzYnOTz0M for <kvmarm@lists.cs.columbia.edu>;
 Thu,  4 Mar 2021 14:35:07 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 071C74B33E
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Mar 2021 14:35:06 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 320AE64F60;
 Thu,  4 Mar 2021 19:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614886506;
 bh=yYKWZ6QndHwWfsOdgKSOMpZxTE7UTXV1JxyvIovkYDE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZpNz8lFeg3deiGdXUSucIiLylskK5XGCqj1AwyqBAb+2N8gZ5XpzwPPTSSHvhQoEx
 ehvWad8VPCVuHb/IPoGG9lnq9HMJstraBLRB+ntMWb/3Qss8JcVGqLtoic7SHvG5Bb
 AjFJ5CIAWumqND6y6Ys73womqixyps7o6Zpy7QWU8YYAOcq+Dkm5GLmEutN9D8ykRh
 w/qrsBjcwcX1jkDf6avPi3fDaVD/G91LUCi/8R70jepn057vy7WEET763yakPLpuDp
 AsfovY+zS9jTC+Zzw7V3u7ZCgoc3mOPGNr8R3A4lEjlvuoMuvNeezxn9Qp5qFy4p/t
 7KNucS/DhjuLQ==
Date: Thu, 4 Mar 2021 19:35:00 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v3 20/32] KVM: arm64: Refactor kvm_arm_setup_stage2()
Message-ID: <20210304193459.GA21950@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-21-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-21-qperret@google.com>
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

On Tue, Mar 02, 2021 at 02:59:50PM +0000, Quentin Perret wrote:
> In order to re-use some of the stage 2 setup code at EL2, factor parts
> of kvm_arm_setup_stage2() out into separate functions.
> 
> No functional change intended.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 26 +++++++++++++++++
>  arch/arm64/kvm/hyp/pgtable.c         | 32 +++++++++++++++++++++
>  arch/arm64/kvm/reset.c               | 42 +++-------------------------
>  3 files changed, 62 insertions(+), 38 deletions(-)

Looks much better than the big header in v2, thanks!

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
