Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E4DBE3B074B
	for <lists+kvmarm@lfdr.de>; Tue, 22 Jun 2021 16:22:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C72149E57;
	Tue, 22 Jun 2021 10:22:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id As+gM4O-geuL; Tue, 22 Jun 2021 10:22:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 377274A003;
	Tue, 22 Jun 2021 10:22:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CE2DE49E8A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Jun 2021 10:21:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hmj4hCYzL5xf for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Jun 2021 10:21:58 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CCE5249E57
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Jun 2021 10:21:58 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A66A1611BF;
 Tue, 22 Jun 2021 14:21:57 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lvhHn-0097g1-MJ; Tue, 22 Jun 2021 15:21:55 +0100
From: Marc Zyngier <maz@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v17 0/6] MTE support for KVM guest
Date: Tue, 22 Jun 2021 15:21:51 +0100
Message-Id: <162437105102.29544.14666831489362675099.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621111716.37157-1-steven.price@arm.com>
References: <20210621111716.37157-1-steven.price@arm.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, will@kernel.org,
 steven.price@arm.com, linux-kernel@vger.kernel.org, Dave.Martin@arm.com,
 peter.maydell@linaro.org, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, quintela@redhat.com, dgilbert@redhat.com,
 drjones@redhat.com, qemu-devel@nongnu.org, tglx@linutronix.de,
 james.morse@arm.com, richard.henderson@linaro.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 Thomas Gleixner <tglx@linutronix.de>, Dave Martin <Dave.Martin@arm.com>
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

On Mon, 21 Jun 2021 12:17:10 +0100, Steven Price wrote:
> This series adds support for using the Arm Memory Tagging Extensions
> (MTE) in a KVM guest.
> 
> Changes since v16[1]:
> 
>  - Dropped the first patch ("Handle race when synchronising tags") as
>    it's not KVM specific and by restricting MAP_SHARED in KVM there is
>    no longer a dependency.
> 
> [...]

Applied to next, thanks!

[1/6] arm64: mte: Sync tags for pages where PTE is untagged
      commit: 69e3b846d8a753f9f279f29531ca56b0f7563ad0
[2/6] KVM: arm64: Introduce MTE VM feature
      commit: ea7fc1bb1cd1b92b42b1d9273ce7e231d3dc9321
[3/6] KVM: arm64: Save/restore MTE registers
      commit: e1f358b5046479d2897f23b1d5b092687c6e7a67
[4/6] KVM: arm64: Expose KVM_ARM_CAP_MTE
      commit: 673638f434ee4a00319e254ade338c57618d6f7e
[5/6] KVM: arm64: ioctl to fetch/store tags in a guest
      commit: f0376edb1ddcab19a473b4bf1fbd5b6bbed3705b
[6/6] KVM: arm64: Document MTE capability and ioctl
      commit: 04c02c201d7e8149ae336ead69fb64e4e6f94bc9

I performed a number of changes in user_mem_abort(), so please
have a look at the result. It is also pretty late in the merge
cycle, so if anything looks amiss, I'll just drop it.

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
