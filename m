Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8904A4B1127
	for <lists+kvmarm@lfdr.de>; Thu, 10 Feb 2022 16:03:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B6C5649F58;
	Thu, 10 Feb 2022 10:03:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CHerDbQsL5wE; Thu, 10 Feb 2022 10:03:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A0E349F31;
	Thu, 10 Feb 2022 10:03:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D2DF649F0A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Feb 2022 10:03:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ubyWo+gYQD1w for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Feb 2022 10:03:50 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 74B5B49F2F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Feb 2022 10:03:50 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5100061AB0;
 Thu, 10 Feb 2022 15:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D93C004E1;
 Thu, 10 Feb 2022 15:03:45 +0000 (UTC)
Date: Thu, 10 Feb 2022 15:03:42 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v11 04/40] kselftest/arm64: Remove local ARRAY_SIZE()
 definitions
Message-ID: <YgUpTgpQfvn5MPd2@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-5-broonie@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-5-broonie@kernel.org>
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

On Mon, Feb 07, 2022 at 03:20:33PM +0000, Mark Brown wrote:
> An ARRAY_SIZE() has been added to kselftest.h so remove the local versions
> in some of the arm64 selftests.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
