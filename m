Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3354029EFBD
	for <lists+kvmarm@lfdr.de>; Thu, 29 Oct 2020 16:27:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9ECCA4B599;
	Thu, 29 Oct 2020 11:27:15 -0400 (EDT)
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
	with ESMTP id UYhzzRZP-sGA; Thu, 29 Oct 2020 11:27:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 83F384B568;
	Thu, 29 Oct 2020 11:27:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 275504B27F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Oct 2020 11:27:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AcAEXoKKnlP6 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 29 Oct 2020 11:27:12 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1654C4B233
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Oct 2020 11:27:12 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5FED020759;
 Thu, 29 Oct 2020 15:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603985230;
 bh=dHOwPIbu8adLWeK2264PAC3Cqkc4KzVueApZwXwuyiQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=romTUC4KfCDrK+Pyt2kasR5dQnxJiB7Fwz/PL6qsJcV7ZXxhj4ZBloFG/L76Q1xc4
 bgNQjzmFHF+91/TnvTj2uxeK6k8ioRP8S1I50XrLezds9B9qlVVf02dzAPxx5djzFw
 M82YDXJI0n0n/rxlT1u5E8YuKdEH4q00IoQDRcJA=
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v7 1/2] arm64: Add part number for Arm Cortex-A77
Date: Thu, 29 Oct 2020 15:27:03 +0000
Message-Id: <160397616208.746530.13318825625774881470.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201028182839.166037-1-robh@kernel.org>
References: <20201028182839.166037-1-robh@kernel.org>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, kernel-team@android.com,
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

On Wed, 28 Oct 2020 13:28:38 -0500, Rob Herring wrote:
> Add the MIDR part number info for the Arm Cortex-A77.

Applied to arm64 (for-next/fixes), thanks!

[1/2] arm64: Add part number for Arm Cortex-A77
      https://git.kernel.org/arm64/c/8a6b88e66233
[2/2] arm64: Add workaround for Arm Cortex-A77 erratum 1508412
      https://git.kernel.org/arm64/c/96d389ca1011

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
