Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3695830FE
	for <lists+kvmarm@lfdr.de>; Wed, 27 Jul 2022 19:45:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 146D34CA2D;
	Wed, 27 Jul 2022 13:45:19 -0400 (EDT)
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
	with ESMTP id akCpM9cUIwV6; Wed, 27 Jul 2022 13:45:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E4BAC4CA22;
	Wed, 27 Jul 2022 13:45:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ADF204CA00
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Jul 2022 13:45:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WlW8+-8t0inP for <kvmarm@lists.cs.columbia.edu>;
 Wed, 27 Jul 2022 13:45:15 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7C5AB4C9FD
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Jul 2022 13:45:15 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id F0807B821F3;
 Wed, 27 Jul 2022 17:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A45C433C1;
 Wed, 27 Jul 2022 17:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658943912;
 bh=cUE9CRxllo0mAyhfZj87hNPzjkFEW5l5CpfwcwuijM4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t+2d+BDDNIP45fdghekyfrC4W9j//nbaPkr0uJNp/ScxjFUg4izLnUKlagQHBJ1el
 Y9pSTvw3Gbi/dtrq6UxluR8oj3IimTJWe6p155MFOtx5pepq13yTti22fuAQVR8AIK
 uPbBt0UO5m/6Vcl5zDqXX1q7Nq899+LsyZKFLcKY58AlNFRk752midVvrwUttjbamM
 VuW4wb1F/0KQ1dXRpNqRgQsAUSkgeI2T5mCFOm5YcDQzJSWytI18H2lX7VVWX4NUUE
 Vr9Rp/RURneTSMVv3ou5eq0id/EGm6eo8GyIbiWxlW9zAyvvYsmiaR5tUMWNHQpzvl
 XVpyysylvnRkw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1oGl5q-00ATrj-1O;
 Wed, 27 Jul 2022 18:45:10 +0100
From: Marc Zyngier <maz@kernel.org>
To: Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] KVM: arm64: nVHE stack unwinder rework
Date: Wed, 27 Jul 2022 18:45:05 +0100
Message-Id: <165894387426.1300284.16409854849904872790.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220727142906.1856759-1-maz@kernel.org>
References: <20220726073750.3219117-18-kaleshsingh@google.com>
 <20220727142906.1856759-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: maz@kernel.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 keirf@google.com, kaleshsingh@google.com, catalin.marinas@arm.com,
 broonie@kernel.org, madvenka@linux.microsoft.com, qperret@google.com,
 wangkefeng.wang@huawei.com, tabba@google.com, ast@kernel.org,
 vincenzo.frascino@arm.com, elver@google.com, mark.rutland@arm.com,
 mhiramat@kernel.org, oupton@google.com, james.morse@arm.com,
 oliver.upton@linux.dev, suzuki.poulose@arm.com, kernel-team@android.com,
 alexandru.elisei@arm.com, ardb@kernel.org, andreyknvl@gmail.com,
 yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: wangkefeng.wang@huawei.com, catalin.marinas@arm.com, ast@kernel.org,
 vincenzo.frascino@arm.com, madvenka@linux.microsoft.com,
 kernel-team@android.com, elver@google.com, broonie@kernel.org,
 andreyknvl@gmail.com, mhiramat@kernel.org
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

On Wed, 27 Jul 2022 15:29:00 +0100, Marc Zyngier wrote:
> As Kalesh's series[1] already went through quite a few rounds and that
> it has proved to be an extremely useful debugging help, I'd like to
> queue it for 5.20.
> 
> However, there is a couple of nits that I'd like to address:
> 
> - the code is extremely hard to follow, due to the include maze and
>   the various levels of inline functions that have forward
>   declarations...
> 
> [...]

Applied to next, thanks!

[1/6] KVM: arm64: Move PROTECTED_NVHE_STACKTRACE around
      commit: 03fe9cd05b9f38353208c23bd791dac47c912054
[2/6] KVM: arm64: Move nVHE stacktrace unwinding into its own compilation unit
      commit: 9f5fee05f6897d0fe0e3a44ade71bb85cd97b2ef
[3/6] KVM: arm64: Make unwind()/on_accessible_stack() per-unwinder functions
      commit: 4e00532f37365967e9896966b1fe61888e659259
[4/6] KVM: arm64: Move nVHE-only helpers into kvm/stacktrace.c
      commit: 0e773da1e688a1425ef7deae58fa11c5c7e09533
[5/6] KVM: arm64: Don't open code ARRAY_SIZE()
      commit: 62ae21627aa96f6ef361981dd181c74dc7aa314c
[6/6] arm64: Update 'unwinder howto'
      commit: a4c750e2328a117dc9b19a2a61db0d4347902029

Cheers,

	M.
-- 
Marc Zyngier <maz@kernel.org>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
