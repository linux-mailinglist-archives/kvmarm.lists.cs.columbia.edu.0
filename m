Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7A5518260
	for <lists+kvmarm@lfdr.de>; Tue,  3 May 2022 12:31:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BA92D4B17B;
	Tue,  3 May 2022 06:31:15 -0400 (EDT)
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
	with ESMTP id sGt0VLSuD3Y5; Tue,  3 May 2022 06:31:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B0724B118;
	Tue,  3 May 2022 06:31:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3EC3E4B0BE
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 May 2022 06:31:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0xRwS5Z8pnF7 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  3 May 2022 06:31:12 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 19D704B091
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 May 2022 06:31:12 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5B3B3B81D40;
 Tue,  3 May 2022 10:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F31DC385A9;
 Tue,  3 May 2022 10:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651573869;
 bh=hdMtNCaYZb86oM3x0a1mVVawEaUeAE4STWQUnxJJi7c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pyOU36JoQjIY3f3xcV03lOxBlmovJ70oM98C7WYLtygXDq8nSkLE9m8Qd1vnAT05u
 FnbS2lrnrvrmoWjfW4TiY6oOT1S8yU7fMTzJen/TfnuVbYuFSSKQLWgY2Q5RNwLQp9
 IrTSDPwn1pVX5LTYZiryHhDhXUwUsCMkMTYMsObJXnWV703f4h8QKe7zNbdpY9q1KW
 EDq0pS8TMBX5CpQzIxL1kNTU9XFV3K22C8McPEnVMufYq94kPXxY5iU1n9rTuAcTnK
 nZEHV4SN9CSag2DBiq68Yo3FGI+9WQeF91CvA521w9XXcfW4FP8usQu9WKJDw6aYBt
 SXtVOKGmzU9Qw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nlpoA-008cWg-Mt; Tue, 03 May 2022 11:31:06 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 0/7] KVM: arm64: Limit feature register reads from
 AArch32
Date: Tue,  3 May 2022 11:31:02 +0100
Message-Id: <165157375706.3129182.12268321822257676050.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220503060205.2823727-1-oupton@google.com>
References: <20220503060205.2823727-1-oupton@google.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, oupton@google.com,
 suzuki.poulose@arm.com, ricarkol@google.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 james.morse@arm.com, reijiw@google.com, alexandru.elisei@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Tue, 3 May 2022 06:01:58 +0000, Oliver Upton wrote:
> KVM/arm64 does not restrict the guest's view of the AArch32 feature
> registers when read from AArch32. HCR_EL2.TID3 is cleared for AArch32
> guests, meaning that register reads come straight from hardware. This is
> problematic as KVM relies on read_sanitised_ftr_reg() to expose a set of
> features consistent for a particular system.
> 
> Appropriate handlers must first be put in place for CP10 and CP15 ID
> register accesses before setting TID3. Rather than exhaustively
> enumerating each of the encodings for CP10 and CP15 registers, take the
> lazy route and aim the register accesses at the AArch64 system register
> table.
> 
> [...]

Applied to next, thanks!

Note that I have dropped the revert for now, as the original patch
lives in a separate branch. I'll clean things up at -rc1.

[1/7] KVM: arm64: Return a bool from emulate_cp()
      commit: 001bb819994cd1bd037b6aefdb233f1720ee2126
[2/7] KVM: arm64: Don't write to Rt unless sys_reg emulation succeeds
      commit: 28eda7b5e82489b9dcffc630af68c207552b4f4d
[3/7] KVM: arm64: Wire up CP15 feature registers to their AArch64 equivalents
      commit: e65197666773f39e4378161925e5a1c7771cff29
[4/7] KVM: arm64: Plumb cp10 ID traps through the AArch64 sysreg handler
      commit: 9369bc5c5e35985f38d04bd98c6d28a032e84b17
[5/7] KVM: arm64: Start trapping ID registers for 32 bit guests
      commit: fd1264c4ca610a99d52c35a37e5551eec442723d
[6/7] KVM/arm64: Hide AArch32 PMU registers when not available
      commit: a9e192cd4fc738469448803693c9dc730898b8f1

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
