Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5C417233368
	for <lists+kvmarm@lfdr.de>; Thu, 30 Jul 2020 15:52:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E94F94B501;
	Thu, 30 Jul 2020 09:52:17 -0400 (EDT)
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
	with ESMTP id fLdc-ZjS9XEF; Thu, 30 Jul 2020 09:52:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E58DE4B4FE;
	Thu, 30 Jul 2020 09:52:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CC2214B4F7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jul 2020 09:52:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S4paes7CPzFb for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 Jul 2020 09:52:14 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DE5354ACC9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jul 2020 09:52:14 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C41022074B;
 Thu, 30 Jul 2020 13:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596117133;
 bh=r/gRPHhAPpag3PUKYG81HrzkMbvKm74zY6qgVadUZjM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lW33+vWwgbIQye4m0sYHmXGL3H7rTAzbHiJ1eDKwB8R1J09wLwKHSZ0LtxDlClk5Y
 +vzLimyF/jYeFL9cEY//YbEuC7jMhzmWJiHXFDoZVISyDlQggwd0lkJO5Nk/+rtAiI
 xmN+5VqQFXjPljqBGduHTpXq5qt33EcNlo7PfJQc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1k18yi-00GGvl-6w; Thu, 30 Jul 2020 14:52:12 +0100
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>, David Brazdil <dbrazdil@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] KVM: arm64: Ensure that all nVHE hyp code is in .hyp.text
Date: Thu, 30 Jul 2020 14:52:09 +0100
Message-Id: <159611709973.1644456.15046238262603869142.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730132519.48787-1-dbrazdil@google.com>
References: <20200730132519.48787-1-dbrazdil@google.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, dbrazdil@google.com,
 catalin.marinas@arm.com, kernel-team@google.com,
 clang-built-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, android-kvm@google.com,
 kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: android-kvm@google.com, linux-kernel@vger.kernel.org,
 clang-built-linux@googlegroups.com, kernel-team@google.com,
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

On Thu, 30 Jul 2020 14:25:19 +0100, David Brazdil wrote:
> Some compilers may put a subset of generated functions into '.text.*'
> ELF sections and the linker may leverage this division to optimize ELF
> layout. Unfortunately, the recently introduced HYPCOPY command assumes
> that all executable code (with the exception of specialized sections
> such as '.hyp.idmap.text') is in the '.text' section. If this
> assumption is broken, code in '.text.*' will be merged into kernel
> proper '.text' instead of the '.hyp.text' that is mapped in EL2.
> 
> [...]

Applied to kvm-arm64/el2-obj-v4.1, thanks!

[1/1] KVM: arm64: Ensure that all nVHE hyp code is in .hyp.text
      commit: bdbc0c7a070c0cbe3009cd271c6ec8d87d69cc7a

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
