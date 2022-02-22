Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 59DB34BF860
	for <lists+kvmarm@lfdr.de>; Tue, 22 Feb 2022 13:53:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C989B4B0CC;
	Tue, 22 Feb 2022 07:53:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level: 
X-Spam-Status: No, score=-1.898 required=6.1 tests=[BAYES_00=-1.9,
	RCVD_IN_DNSWL_BLOCKED=0.001, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ePvjO5IHlgN7; Tue, 22 Feb 2022 07:53:57 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8338E4B0B6;
	Tue, 22 Feb 2022 07:53:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C1CE49F28
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 07:53:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X742+Tlp+V8B for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Feb 2022 07:53:54 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3E63449EF2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 07:53:54 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4EDF0B818FA;
 Tue, 22 Feb 2022 12:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B357C340E8;
 Tue, 22 Feb 2022 12:53:49 +0000 (UTC)
Date: Tue, 22 Feb 2022 12:53:46 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v11 17/40] arm64/sme: Implement ZA context switching
Message-ID: <YhTc2i/id7Ez52mN@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-18-broonie@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-18-broonie@kernel.org>
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Will Deacon <will@kernel.org>, Luis Machado <luis.machado@arm.com>,
 Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 Shuah Khan <shuah@kernel.org>, kvmarm@lists.cs.columbia.edu,
 Salil Akerkar <Salil.Akerkar@arm.com>
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

On Mon, Feb 07, 2022 at 03:20:46PM +0000, Mark Brown wrote:
> Allocate space for storing ZA on first access to SME and use that to save
> and restore ZA state when context switching. We do this by using the vector
> form of the LDR and STR ZA instructions, these do not require streaming
> mode and have implementation recommendations that they avoid contention
> issues in shared SMCU implementations.
> 
> Since ZA is architecturally guaranteed to be zeroed when enabled we do not
> need to explicitly zero ZA, either we will be restoring from a saved copy
> or trapping on first use of SME so we know that ZA must be disabled.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
