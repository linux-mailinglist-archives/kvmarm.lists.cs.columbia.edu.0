Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD91145BB8
	for <lists+kvmarm@lfdr.de>; Wed, 22 Jan 2020 19:50:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D281A4AEED;
	Wed, 22 Jan 2020 13:50:27 -0500 (EST)
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
	with ESMTP id LpSzudJpePbN; Wed, 22 Jan 2020 13:50:27 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A96984AED0;
	Wed, 22 Jan 2020 13:50:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5B5914AE92
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jan 2020 13:50:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eGbFWwMQvN0E for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Jan 2020 13:50:24 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 65FBE4A968
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jan 2020 13:50:24 -0500 (EST)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 426D5217F4;
 Wed, 22 Jan 2020 18:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579719023;
 bh=fQoQAjUDEAVwQrQeHLA+HkE9LCpRN8ToPkGfhrFGRTI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=b+Ot0Q5erq2ofBuHbSY4jl60BHqd5jvaTS2Z5b8zY9E2CCjpW/gUY7SmA6zxes5u5
 bi2BHeBPk6IhlFZECSrGz8HnFEfhJ/4Xept9OHvYsE9MiemYO4T6gr5/d3FMtJxid7
 4ziXuAQ8YYQEQWVs78cHw3ipxSjKjkn0OWuYacAs=
Date: Wed, 22 Jan 2020 18:50:17 +0000
From: Will Deacon <will@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 0/1] arm/arm64: add support for folded p4d page tables
Message-ID: <20200122185017.GA17321@willie-the-truck>
References: <20200113111323.10463-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200113111323.10463-1-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Marc Zyngier <maz@kernel.org>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Mike Rapoport <rppt@linux.ibm.com>,
 kvmarm@lists.cs.columbia.edu
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

On Mon, Jan 13, 2020 at 01:13:22PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> This is a part of clean up of the page table manipulation code that aims to
> remove asm-generic/5level-fixup.h and asm-generic/pgtable-nop4d-hack.h
> 
> There is a single patch for both arm and arm64 because doing the conversion
> separately would mean breaking the shared mmu bits in virt/kvm/arm.

Unfortunately, that's going to be really hard to merge, as the two
architectures are maintained in different trees and the breadth of this
patch series is likely to lead to conflicts in both.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
