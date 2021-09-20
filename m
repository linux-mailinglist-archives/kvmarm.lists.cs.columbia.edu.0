Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 26AAA4113B8
	for <lists+kvmarm@lfdr.de>; Mon, 20 Sep 2021 13:45:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 740994B0EF;
	Mon, 20 Sep 2021 07:45:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bCeVb1cDX9ZY; Mon, 20 Sep 2021 07:45:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5103C4B0DB;
	Mon, 20 Sep 2021 07:44:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E93F40191
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Sep 2021 07:44:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yM0mhoxeb1Mn for <kvmarm@lists.cs.columbia.edu>;
 Mon, 20 Sep 2021 07:44:57 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A69E140159
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Sep 2021 07:44:57 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ABBFF60F9B;
 Mon, 20 Sep 2021 11:44:56 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mSHjC-00BkWM-Rs; Mon, 20 Sep 2021 12:44:54 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH] KVM: arm64: nvhe: Fix missing FORCE for hyp-reloc.S build
 rule
Date: Mon, 20 Sep 2021 12:44:43 +0100
Message-Id: <163213827748.1972803.17900179981983234782.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907052137.1059-1-yuzenghui@huawei.com>
References: <20210907052137.1059-1-yuzenghui@huawei.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 yuzenghui@huawei.com, masahiroy@kernel.org, dbrazdil@google.com,
 suzuki.poulose@arm.com, james.morse@arm.com, alexandru.elisei@arm.com,
 wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Masahiro Yamada <masahiroy@kernel.org>
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

On Tue, 7 Sep 2021 13:21:37 +0800, Zenghui Yu wrote:
> Add FORCE so that if_changed can detect the command line change.
> 
> We'll otherwise see a compilation warning since commit e1f86d7b4b2a
> ("kbuild: warn if FORCE is missing for if_changed(_dep,_rule) and
> filechk").
> 
> arch/arm64/kvm/hyp/nvhe/Makefile:58: FORCE prerequisite is missing

Applied to fixes, thanks!

[1/1] KVM: arm64: nvhe: Fix missing FORCE for hyp-reloc.S build rule
      commit: a49b50a3c1c3226d26e1dd11e8b763f27e477623

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
