Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9D78454004E
	for <lists+kvmarm@lfdr.de>; Tue,  7 Jun 2022 15:43:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8EDCF4B350;
	Tue,  7 Jun 2022 09:43:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G6XFddbMCjzO; Tue,  7 Jun 2022 09:43:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5B7E94B335;
	Tue,  7 Jun 2022 09:43:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A51214B0D0
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Jun 2022 09:43:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pj2BXQvSqgb7 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  7 Jun 2022 09:43:51 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7FFB64B0CE
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Jun 2022 09:43:51 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9BA9E614D9;
 Tue,  7 Jun 2022 13:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2785C385A5;
 Tue,  7 Jun 2022 13:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654609430;
 bh=zJAgHSfeuULjeQ226gU3vnExepgqfXsDdzVQZfb1jyc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ddjfLvsDSgKgyGnPJwpKyJcvwj3H/euPSrL9jFyylGy6RuWF8wwQWc95bsGgGOkfa
 emF5DAnLBScWWHLaiMK6IOzj3O3TVoQixDbrZiI8nu6qZ58OQYGvUw0lqqoy4Jl0RN
 1iuQDj7HqWtBDFY6ZO4ByOnoLI10YYsE9ebHvle4aoO9qPIVBm+4PuMUO0z962mRgi
 5SxFZD0WOtU7a35SUNRGwqXFAKNrxfOE5K7qc9pi1Dda/baJpywzoj/O9ctC5AlVGG
 q3ed03OiJuGr7X5X3GiRfA+QanLMbM1EnK7r7R+3UVmbYV+p4cCVWVz0HkxaPVPvVC
 8fd//Fmj0bOeA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nyZUp-00GC0V-Ck; Tue, 07 Jun 2022 14:43:47 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/18] KVM/arm64: Refactoring the vcpu flags
Date: Tue,  7 Jun 2022 14:43:44 +0100
Message-Id: <165460926051.126720.11200694374756872451.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220528113829.1043361-1-maz@kernel.org>
References: <20220528113829.1043361-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 maz@kernel.org, linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 broonie@kernel.org, kernel-team@android.com, will@kernel.org,
 suzuki.poulose@arm.com, qperret@google.com, alexandru.elisei@arm.com,
 tabba@google.com, oupton@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
 kernel-team@android.com
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

On Sat, 28 May 2022 12:38:10 +0100, Marc Zyngier wrote:
> While working on pKVM, it slowly became apparent that dealing with the
> flags was a pain, as they serve multiple purposes:
> 
> - some flags are purely a configuration artefact,
> 
> - some are an input from the host kernel to the world switch,
> 
> [...]

Applied to fixes, thanks!

[01/18] KVM: arm64: Always start with clearing SVE flag on load
        commit: d52d165d67c5aa26c8c89909003c94a66492d23d
[02/18] KVM: arm64: Always start with clearing SME flag on load
        commit: 039f49c4cafb785504c678f28664d088e0108d35

Cheers,

	M.
-- 
Marc Zyngier <maz@kernel.org>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
