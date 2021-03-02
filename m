Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF532A9EC
	for <lists+kvmarm@lfdr.de>; Tue,  2 Mar 2021 19:57:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C6794B6D6;
	Tue,  2 Mar 2021 13:57:34 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wPmhKbPfIf-y; Tue,  2 Mar 2021 13:57:33 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CAE8C4B461;
	Tue,  2 Mar 2021 13:57:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D07EB4B461
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Mar 2021 13:57:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y6HFkKb4CgGG for <kvmarm@lists.cs.columbia.edu>;
 Tue,  2 Mar 2021 13:57:27 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 805824B444
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Mar 2021 13:57:27 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D528B64F2F;
 Tue,  2 Mar 2021 18:57:25 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lHACy-00GmGh-4N; Tue, 02 Mar 2021 18:57:24 +0000
From: Marc Zyngier <maz@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] kvm: arm64: nvhe: Save the SPE context early
Date: Tue,  2 Mar 2021 18:57:11 +0000
Message-Id: <161471117620.3770794.12358302238773672698.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210302120345.3102874-1-suzuki.poulose@arm.com>
References: <20210302120345.3102874-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: suzuki.poulose@arm.com, anshuman.khandual@arm.com,
 linux-arm-kernel@lists.infradead.org, christoffer.dall@arm.com,
 mark.rutland@arm.com, stable@vger.kernel.org, will@kernel.org,
 catalin.marinas@arm.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 alexandru.elisei@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, anshuman.khandual@arm.com,
 Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

On Tue, 2 Mar 2021 12:03:45 +0000, Suzuki K Poulose wrote:
> The nVHE KVM hyp drains and disables the SPE buffer, before
> entering the guest, as the EL1&0 translation regime
> is going to be loaded with that of the guest.
> 
> But this operation is performed way too late, because :
>   - The owning translation regime of the SPE buffer
>     is transferred to EL2. (MDCR_EL2_E2PB == 0)
>   - The guest Stage1 is loaded.
> 
> [...]

Applied to kvmarm-master/fixes, thanks!

[1/1] kvm: arm64: nvhe: Save the SPE context early
      commit: cfe1e2b6949785e90e84918295f2be1b6fd152b6

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
