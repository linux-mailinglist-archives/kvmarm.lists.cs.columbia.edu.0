Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1BD508E6D
	for <lists+kvmarm@lfdr.de>; Wed, 20 Apr 2022 19:28:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 159524B203;
	Wed, 20 Apr 2022 13:28:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LrRNV5RGVpiG; Wed, 20 Apr 2022 13:28:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C39894B1CB;
	Wed, 20 Apr 2022 13:28:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8246A4A193
 for <kvmarm@lists.cs.columbia.edu>; Wed, 20 Apr 2022 13:28:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OXdFCKe9jjO2 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 20 Apr 2022 13:28:21 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6FE8D49F10
 for <kvmarm@lists.cs.columbia.edu>; Wed, 20 Apr 2022 13:28:21 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8C56CB82123;
 Wed, 20 Apr 2022 17:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F9EC385A0;
 Wed, 20 Apr 2022 17:28:16 +0000 (UTC)
Date: Wed, 20 Apr 2022 18:28:13 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 09/10] arm64: Add wfet()/wfit() helpers
Message-ID: <YmBCrbWRFcTgeBDg@arm.com>
References: <20220419182755.601427-1-maz@kernel.org>
 <20220419182755.601427-10-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220419182755.601427-10-maz@kernel.org>
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Joey Gouly <joey.gouly@arm.com>, Will Deacon <will@kernel.org>,
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

On Tue, Apr 19, 2022 at 07:27:54PM +0100, Marc Zyngier wrote:
> Just like we have helpers for WFI and WFE, add the WFxT versions.
> Note that the encoding is that reported by objdump, as no currrent
> toolchain knows about these instructions yet.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
