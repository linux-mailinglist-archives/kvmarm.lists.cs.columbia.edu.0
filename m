Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9865A46A2F9
	for <lists+kvmarm@lfdr.de>; Mon,  6 Dec 2021 18:28:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 175D04A19A;
	Mon,  6 Dec 2021 12:28:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GlssHbnyy01S; Mon,  6 Dec 2021 12:28:32 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BB4A14B091;
	Mon,  6 Dec 2021 12:28:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1882F4A1B0
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Dec 2021 12:28:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o2CC+m4+v28C for <kvmarm@lists.cs.columbia.edu>;
 Mon,  6 Dec 2021 12:28:28 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2F7EF4A19A
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Dec 2021 12:28:28 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 63D04B810E8;
 Mon,  6 Dec 2021 17:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A74C341C5;
 Mon,  6 Dec 2021 17:28:22 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] arm64/kvm: Fix bitrotted comment for SVE handling in
 handle_exit.c
Date: Mon,  6 Dec 2021 17:28:20 +0000
Message-Id: <163881168906.164288.4160136358061156637.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025163232.3502052-1-broonie@kernel.org>
References: <20211025163232.3502052-1-broonie@kernel.org>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

On Mon, 25 Oct 2021 17:32:32 +0100, Mark Brown wrote:
> The comment on the SVE trap handler in handle_exit.c says that it is a
> placeholder until we support SVE in guests which we now do for both VHE
> and nVHE cases so we really shouldn't get here in any sort of standard
> case. Update the comment to be less immediately incorrect, the handling
> of such a situation is correct.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/kvm: Fix bitrotted comment for SVE handling in handle_exit.c
      https://git.kernel.org/arm64/c/d658220a1c45

-- 
Catalin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
