Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9B53520385B
	for <lists+kvmarm@lfdr.de>; Mon, 22 Jun 2020 15:41:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1480D4B0F0;
	Mon, 22 Jun 2020 09:41:40 -0400 (EDT)
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
	with ESMTP id ApKtrtSVk-zk; Mon, 22 Jun 2020 09:41:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DD2044B0E3;
	Mon, 22 Jun 2020 09:41:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 93C2E4B0CE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jun 2020 09:41:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LZfN9Xiyv9GN for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Jun 2020 09:41:36 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5CF2F4B0C1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jun 2020 09:41:36 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8D43B20738;
 Mon, 22 Jun 2020 13:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592833295;
 bh=V9HgnMaqIzfFVCisajzYw6xWtn5XxqoVR2LehnRXRg4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=S4RisWB7QV2GO23Tl7QI1mDr/l9CJX+DVFPZO57ChOd9oQ9QaL6+YrWKKgy1QaFXn
 kDrD3y/0+JAIVAR7cuLsE1odFdmY3lyiLJf6H3OyKGpK+QN7KZhh+2bBFA/g4z98Qg
 Xs63zL52x8we+eOuG92QoHkQPMym2xH0ZhQHh9AQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jnMha-005KkL-2W; Mon, 22 Jun 2020 14:41:34 +0100
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Steven Price <steven.price@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] KVM: arm64: kvm_reset_vcpu() return code incorrect
 with SVE
Date: Mon, 22 Jun 2020 14:41:27 +0100
Message-Id: <159283326373.239821.12024358556490900113.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617105456.28245-1-steven.price@arm.com>
References: <20200617105456.28245-1-steven.price@arm.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 catalin.marinas@arm.com, steven.price@arm.com, will@kernel.org,
 james.morse@arm.com, suzuki.poulose@arm.com, julien.thierry.kdev@gmail.com,
 linux-kernel@vger.kernel.org, Dave.Martin@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
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

On Wed, 17 Jun 2020 11:54:56 +0100, Steven Price wrote:
> If SVE is enabled then 'ret' can be assigned the return value of
> kvm_vcpu_enable_sve() which may be 0 causing future "goto out" sites to
> erroneously return 0 on failure rather than -EINVAL as expected.
> 
> Remove the initialisation of 'ret' and make setting the return value
> explicit to avoid this situation in the future.

Applied to next, thanks!

[1/1] KVM: arm64: Fix kvm_reset_vcpu() return code being incorrect with SVE
      commit: 66b7e05dc0239c5817859f261098ba9cc2efbd2b

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
