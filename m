Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6BF2306AD
	for <lists+kvmarm@lfdr.de>; Tue, 28 Jul 2020 11:37:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 084764B93F;
	Tue, 28 Jul 2020 05:37:33 -0400 (EDT)
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
	with ESMTP id hkIytUYlEdJE; Tue, 28 Jul 2020 05:37:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D2C834B939;
	Tue, 28 Jul 2020 05:37:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2811E4B914
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 Jul 2020 05:37:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cyY5zjX2oZld for <kvmarm@lists.cs.columbia.edu>;
 Tue, 28 Jul 2020 05:37:29 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 082D94B846
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 Jul 2020 05:37:29 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D376E207E8;
 Tue, 28 Jul 2020 09:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595929048;
 bh=wP02xrsKYUNmDyHtJarWzJDBrD/jNyRBXPSTSxeL+zQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aXfGdVzYn6gO0cgYQPI+TElG3KbeGPHH7dlI6qTqsutL4c+leW9+MchRkUpbG8FAs
 gy9b1TsZmIq2Pap3ODFIYAx+d5yKhTCTLRqN36RURwomWTnP2GlEE7iJtcwaiUAR58
 TtijSnIpvmFSkRrSBDq5e6QH6GxuXCyZyXGdQzQs=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1k0M34-00Fbfk-BE; Tue, 28 Jul 2020 10:37:26 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] KVM: arm64: Don't inherit exec permission across
 page-table levels
Date: Tue, 28 Jul 2020 10:37:22 +0100
Message-Id: <159592902849.3866216.16184306169833610349.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723101714.15873-1-will@kernel.org>
References: <20200723101714.15873-1-will@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, will@kernel.org,
 kernel-team@android.com, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
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

On Thu, 23 Jul 2020 11:17:14 +0100, Will Deacon wrote:
> If a stage-2 page-table contains an executable, read-only mapping at the
> pte level (e.g. due to dirty logging being enabled), a subsequent write
> fault to the same page which tries to install a larger block mapping
> (e.g. due to dirty logging having been disabled) will erroneously inherit
> the exec permission and consequently skip I-cache invalidation for the
> rest of the block.
> 
> [...]

Applied to kvm-arm64/fixes-5.8-3, thanks!

[1/1] KVM: arm64: Don't inherit exec permission across page-table levels
      commit: b757b47a2fcba584d4a32fd7ee68faca510ab96f

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
