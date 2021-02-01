Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 375AF30AE4D
	for <lists+kvmarm@lfdr.de>; Mon,  1 Feb 2021 18:46:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AEEFD4B373;
	Mon,  1 Feb 2021 12:46:48 -0500 (EST)
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
	with ESMTP id k98UnAeBA8-s; Mon,  1 Feb 2021 12:46:48 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 866384B1CC;
	Mon,  1 Feb 2021 12:46:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 988A04B1CC
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Feb 2021 12:46:46 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nv+Lph5JUbQd for <kvmarm@lists.cs.columbia.edu>;
 Mon,  1 Feb 2021 12:46:45 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B4A934B372
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Feb 2021 12:46:45 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01F2964E2A;
 Mon,  1 Feb 2021 17:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612201604;
 bh=+LG8JJC83lkhV2mXkT0DrcP7GWmpNTMsT8hay1pPWhg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Lq8FUTr3dPjyr2lA53+NzwaAZ6xMno3oS9wye3cjVCTF7C0RP9XfAL0ZeQUECfH6M
 yRg6/JVHBih3p+LNNdST5NXyG4iQ/m3iyVYdnjDiSO3Htunc2NRf6NayMm4Ol9IiRT
 ekz7ClGHRYPHXBi4zcf1xXUfMDmlMylwk4YCUjYDSV8h7/XcHphODxoH2SIdJNwmeL
 DheBNhjve/Xx7i6XU7JPzDHuxojj9NNodM0vbjzqojXInQtfyv+n4V8r3ohBgXPcgr
 6gUZXJI2uceTQtnS1hVDRephIznxUrwSgYfo/QgtvaC2eRZzQ/5IqhCdCDxDCYEF0T
 zFQ+KiVsfmtNw==
Date: Mon, 1 Feb 2021 17:46:38 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [RFC PATCH v2 05/26] KVM: arm64: Avoid free_page() in page-table
 allocator
Message-ID: <20210201174638.GC15632@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-6-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-6-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, kernel-team@android.com, android-kvm@google.com,
 Catalin Marinas <catalin.marinas@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, kvmarm@lists.cs.columbia.edu
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

On Fri, Jan 08, 2021 at 12:15:03PM +0000, Quentin Perret wrote:
> Currently, the KVM page-table allocator uses a mix of put_page() and
> free_page() calls depending on the context even though page-allocation
> is always achieved using variants of __get_free_page().
> 
> Make the code consitent by using put_page() throughout, and reduce the

typo: consistent

> memory management API surface used by the page-table code. This will
> ease factoring out page-alloction from pgtable.c, which is a
> pre-requisite to creating page-tables at EL2.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
