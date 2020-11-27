Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4C59B2C6C20
	for <lists+kvmarm@lfdr.de>; Fri, 27 Nov 2020 20:47:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DC7084B704;
	Fri, 27 Nov 2020 14:47:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oorMqWNaXP+u; Fri, 27 Nov 2020 14:47:40 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E1EBF4B8AA;
	Fri, 27 Nov 2020 14:47:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7365E4B79F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Nov 2020 14:47:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1we7j1jUeFwZ for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 Nov 2020 14:47:37 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 86F3E4B704
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Nov 2020 14:47:37 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4072420885;
 Fri, 27 Nov 2020 19:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606506456;
 bh=E4Xw2UALw2gG/o50RD2ZdpFI8M+G0YGs2VL7UrXLG+U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zLSL2n69ZTVMec7aXivZFZwiWnc8hmiCL+kG42eiRgWS1zrtud7RU4tTe1g3x3F9i
 uXhRol7nuo+fyqG8fm9hKxDseEo6UxZIDEPoe023pfnneuj4LjmQJEaJlF8CjABilc
 DhlBv+8qnx0gkC0srhbKfErAkWpkmd0vj64PvreM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kijiQ-00E9BK-B8; Fri, 27 Nov 2020 19:47:34 +0000
From: Marc Zyngier <maz@kernel.org>
To: Andrew Jones <drjones@redhat.com>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: Re: [PATCH 0/2] KVM: arm64: Fix DEMUX register access
Date: Fri, 27 Nov 2020 19:47:30 +0000
Message-Id: <160650643709.6468.11593626862508119672.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126134641.35231-1-drjones@redhat.com>
References: <20201126134641.35231-1-drjones@redhat.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: drjones@redhat.com, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, pbonzini@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: pbonzini@redhat.com
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

On Thu, 26 Nov 2020 14:46:39 +0100, Andrew Jones wrote:
> The first patch is a fix, but not one likely to ever truly be needed,
> as it's unlikely to find seven levels of cache. The bug was found
> while code reading. Writing the second patch was actually why I was
> reading the code. The issue being fixed for the get-reg-list test was
> found when running it on a different machine than what was used to
> develop it.
> 
> [...]

Applied to kvm-arm64/cache-demux, thanks!

[1/2] KVM: arm64: CSSELR_EL1 max is 13
      commit: c73a44161776f6e60d933717f3b34084b0a0eba0
[2/2] KVM: arm64: selftests: Filter out DEMUX registers
      commit: c6232bd40b2eda3819d108e6e3f621ec604e15d8

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
