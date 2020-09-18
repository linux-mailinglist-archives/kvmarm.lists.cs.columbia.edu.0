Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4C56527016E
	for <lists+kvmarm@lfdr.de>; Fri, 18 Sep 2020 17:57:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EFF2C4B1DD;
	Fri, 18 Sep 2020 11:57:14 -0400 (EDT)
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
	with ESMTP id hB-PlrHj376x; Fri, 18 Sep 2020 11:57:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C790A4B1E6;
	Fri, 18 Sep 2020 11:57:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C0084B1D1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Sep 2020 11:57:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 22yJspMxHRUz for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Sep 2020 11:57:10 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7E5EF4B17E
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Sep 2020 11:57:10 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 692A523888;
 Fri, 18 Sep 2020 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600444629;
 bh=PdF+ayFUhhJsfn7hhMsoEphK5EyRWrr3C1RcsQrHJfI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YA4UW8NERf29czg29MO/aKLAnyK5tESjahQpe7oQX5smwlXMikprXUXpTPakgPw1z
 dFHDQGA8D3SjMQg87PG1JRoQ5VzG2IG0K+wsUHO9HkMPXdRuDREQa0e0aIlnm/yKJp
 v6UXde5XwpjKqQ494NtRickHph81ceglvFZm+19w=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kJIl1-00D3F2-Uw; Fri, 18 Sep 2020 16:57:08 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
 Alexandru Elisei <alexandru.elisei@arm.com>, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v2] KVM: arm64: Try PMD block mappings if PUD mappings are
 not supported
Date: Fri, 18 Sep 2020 16:56:58 +0100
Message-Id: <160044458393.1301915.7507112806066331585.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910133351.118191-1-alexandru.elisei@arm.com>
References: <20200910133351.118191-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu,
 punit1.agrawal@toshiba.co.jp
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: punit1.agrawal@toshiba.co.jp
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

On Thu, 10 Sep 2020 14:33:51 +0100, Alexandru Elisei wrote:
> When userspace uses hugetlbfs for the VM memory, user_mem_abort() tries to
> use the same block size to map the faulting IPA in stage 2. If stage 2
> cannot the same block mapping because the block size doesn't fit in the
> memslot or the memslot is not properly aligned, user_mem_abort() will fall
> back to a page mapping, regardless of the block size. We can do better for
> PUD backed hugetlbfs by checking if a PMD block mapping is supported before
> deciding to use a page.
> 
> [...]

Applied to next, thanks!

[1/1] KVM: arm64: Try PMD block mappings if PUD mappings are not supported
      commit: 523b3999e5f620cb5ccce6a7ca2780a4cab579a2

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
