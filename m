Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 54F822AD348
	for <lists+kvmarm@lfdr.de>; Tue, 10 Nov 2020 11:15:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E6DBC4B7CF;
	Tue, 10 Nov 2020 05:15:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@infradead.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Vy0W9a9mOo8; Tue, 10 Nov 2020 05:15:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AEBDC4B6ED;
	Tue, 10 Nov 2020 05:15:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7A9F84B4DF
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Nov 2020 05:15:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a-v+nFsEn20b for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Nov 2020 05:15:46 -0500 (EST)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CCC524B4B6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Nov 2020 05:15:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=CDnrTQO3oLKsIPoRXOWKhlw6v2wORA6EgStmJKbRLyc=; b=uHCxhFHSswLZ7vAYcHATP5bd/m
 FT+iCClwmwUEk/6LfQTpnR278IY/btZYg8TEOY20uE6JtYZp9jxRJKMxXyUotRqA9KdH0W8moJ9z1
 Qy7+BivKZx7GsMNa+bXMiNXemztq0qnU18Mf3JIqDyLznHGWz6VDfQ7z2FSz8kgSa2NZhFgZ7eP4t
 Ro1PVrsDK8oAOkWRsKhC7EGufL0j2dMUP6xVaKSuEZTdEtgVfbmlVs1DQLzd3JEPG3Lh3MtU3ZFFH
 53eB7sHqkRw/FVQqvStXNAnB75H+vIfjnMzQkxUX/i7n/lFovYYPDz8BRKX03VnVipQwbkg399bXm
 Zlm92mdg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kcQgg-00054V-8l; Tue, 10 Nov 2020 10:15:42 +0000
Date: Tue, 10 Nov 2020 10:15:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v1 00/24] Opt-in always-on nVHE hypervisor
Message-ID: <20201110101542.GA17572@infradead.org>
References: <20201109113233.9012-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Andrew Walbran <qwandor@google.com>, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Tejun Heo <tj@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

On Mon, Nov 09, 2020 at 11:32:09AM +0000, David Brazdil wrote:
> As we progress towards being able to keep guest state private to the
> host running nVHE hypervisor, this series allows the hypervisor to
> install itself on newly booted CPUs before the host is allowed to run
> on them.

Why?  I thought we were trying to kill nVHE off now that newer CPUs
provide the saner virtualization extensions?
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
