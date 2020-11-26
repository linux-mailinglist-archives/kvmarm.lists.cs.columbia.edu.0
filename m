Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ED2022C58DD
	for <lists+kvmarm@lfdr.de>; Thu, 26 Nov 2020 16:57:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A3F1C4BC84;
	Thu, 26 Nov 2020 10:57:58 -0500 (EST)
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
	with ESMTP id 6LveVOI4P5wF; Thu, 26 Nov 2020 10:57:58 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A96C84BC6E;
	Thu, 26 Nov 2020 10:57:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D989B4BC64
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 10:57:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id llt9FjORgL+n for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 Nov 2020 10:57:53 -0500 (EST)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 502EC4BC59
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 10:57:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=l3rrtQ71q0YtViU9F1ot5BdeEltZAdYdBUvO0cmayAc=; b=FZwZ+cSjTlY++W2PqTlACC7Zcm
 0s3m3bFs39K+17ZoKkUILRrMAaHt3+Wwakbs7aeZvux4KTCJ5BzDDbnVayZmgnbMIDEDMx8HpbHdv
 zPAqxNP8urL+nYCRljUztGgpLjge8Vks7oa+D8lkhn6K/ReZvaN64vYFe/jgPeJL3tkdjPoNL56Fz
 b6J9rloVzUz1OxLJzP9NHQuQ4+q1c0iUYcP9XU1D6OKD2Rai9JfwAv6ot1DLV2QyIMXuDmyElds5w
 akkzY+mZfOV1FxpPTFywh6DHTpaceL3+G0tK3lKxidGeTkm+JpmsGmEc8jyYFHoq/7XYgTIk8AJVm
 YqyQffHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1kiJeU-0007oi-MN; Thu, 26 Nov 2020 15:57:46 +0000
Date: Thu, 26 Nov 2020 15:57:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v3 00/23] Opt-in always-on nVHE hypervisor
Message-ID: <20201126155746.GU4327@casper.infradead.org>
References: <20201126155421.14901-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kernel-team@android.com,
 Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org,
 Marc Zyngier <maz@kernel.org>, Tejun Heo <tj@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

On Thu, Nov 26, 2020 at 03:53:58PM +0000, David Brazdil wrote:
> The hypervisor starts trapping host SMCs and intercepting host's PSCI
> CPU_ON/SUSPEND calls. It replaces the host's entry point with its own,
> initializes the EL2 state of the new CPU and installs the nVHE hyp vector
> before ERETing to the host's entry point.

I hate CPU people.  This is complete gibberish to anyone who doesn't
already have their head deep in ... whatever you're talking about.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
