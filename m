Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 455EE26FBF5
	for <lists+kvmarm@lfdr.de>; Fri, 18 Sep 2020 14:00:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D853D4B2F5;
	Fri, 18 Sep 2020 08:00:54 -0400 (EDT)
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
	with ESMTP id svHpE+W0Mfkw; Fri, 18 Sep 2020 08:00:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F7A84B2F1;
	Fri, 18 Sep 2020 08:00:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B4184B23A
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Sep 2020 08:00:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mXn70HlO29yh for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Sep 2020 08:00:51 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4065D4B14E
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Sep 2020 08:00:51 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 23D332072E;
 Fri, 18 Sep 2020 12:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600430450;
 bh=I3H/gm1g/hyAxhRCcYKSEHmYZeKOlQUJYHZFfgz+YQA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R6FJM1GR9moczcLCnPkVOGoJiHnqyJJNElwhuj4HWhIp7YN+fwrBtRu/GdLjJoBn4
 3W17b9y4SjtpGZ9+kyBtboSyqiGjpfJMAtrdnV4+Yg0RG4TNwRrz9BG+hMJSnQ3tL7
 wIc9awOFCRUGttRK8ruoYtiyksBJoNq5aTvNpD2Y=
Date: Fri, 18 Sep 2020 13:00:44 +0100
From: Will Deacon <will@kernel.org>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v3 09/11] kvm: arm64: Mark hyp stack pages reserved
Message-ID: <20200918120044.GC31096@willie-the-truck>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-10-dbrazdil@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200916173439.32265-10-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Christoph Lameter <cl@linux.com>, kernel-team@android.com,
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

On Wed, Sep 16, 2020 at 06:34:37PM +0100, David Brazdil wrote:
> In preparation for unmapping hyp pages from host stage-2, allocate/free hyp
> stack using new helpers which automatically mark the pages reserved.

Given that this series doesn't get us that the point of having a stage-2 for
the host, I don't see why we need this part yet.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
