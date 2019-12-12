Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0708B11D023
	for <lists+kvmarm@lfdr.de>; Thu, 12 Dec 2019 15:46:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 76FFC4ACD6;
	Thu, 12 Dec 2019 09:46:41 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F-jqGwFJRtnL; Thu, 12 Dec 2019 09:46:41 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4A7CA4ACB7;
	Thu, 12 Dec 2019 09:46:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D7C4E4A7F1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Dec 2019 09:46:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bmRDMmDiA2F9 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 12 Dec 2019 09:46:37 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BBC044A59D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Dec 2019 09:46:37 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33238DA7;
 Thu, 12 Dec 2019 06:46:37 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F09C13F6CF;
 Thu, 12 Dec 2019 06:46:35 -0800 (PST)
Date: Thu, 12 Dec 2019 14:46:33 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64: Introduce ISAR6 CPU ID register
Message-ID: <20191212144633.GE46910@lakrids.cambridge.arm.com>
References: <1576145663-9909-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1576145663-9909-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Thu, Dec 12, 2019 at 03:44:23PM +0530, Anshuman Khandual wrote:
> +#define ID_ISAR6_JSCVT_SHIFT		0
> +#define ID_ISAR6_DP_SHIFT		4
> +#define ID_ISAR6_FHM_SHIFT		8
> +#define ID_ISAR6_SB_SHIFT		12
> +#define ID_ISAR6_SPECRES_SHIFT		16
> +#define ID_ISAR6_BF16_SHIFT		20
> +#define ID_ISAR6_I8MM_SHIFT		24

> @@ -399,6 +399,7 @@ static const struct __ftr_reg_entry {
>  	ARM64_FTR_REG(SYS_ID_ISAR4_EL1, ftr_generic_32bits),
>  	ARM64_FTR_REG(SYS_ID_ISAR5_EL1, ftr_id_isar5),
>  	ARM64_FTR_REG(SYS_ID_MMFR4_EL1, ftr_id_mmfr4),

> +	ARM64_FTR_REG(SYS_ID_ISAR6_EL1, ftr_generic_32bits),

Using ftr_generic_32bits exposes the lowest-common-denominator for all
4-bit fields in the register, and I don't think that's the right thing
to do here, because:

* We have no idea what ID_ISAR6 bits [31:28] may mean in future.

* AFAICT, the instructions described by ID_ISAR6.SPECRES (from the
  ARMv8.0-PredInv extension) operate on the local PE and are not
  broadcast. To make those work as a guest expects, the host will need
  to do additional things (e.g. to preserve that illusion when a vCPU is
  migrated from one pCPU to another and back).

Given that, think we should add an explicit ftr_id_isar6 which only
exposes the fields that we're certain are safe to expose to a guest
(i.e. without SPECRES).

Thanks,
Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
