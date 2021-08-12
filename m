Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF533EA125
	for <lists+kvmarm@lfdr.de>; Thu, 12 Aug 2021 10:59:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 027864A2E5;
	Thu, 12 Aug 2021 04:59:09 -0400 (EDT)
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
	with ESMTP id 0HMfES4MtaMq; Thu, 12 Aug 2021 04:59:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D11C84A198;
	Thu, 12 Aug 2021 04:59:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B6BA4083E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Aug 2021 04:59:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5XEJBkcrnsa8 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 12 Aug 2021 04:59:05 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3F53440839
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Aug 2021 04:59:05 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E52A860C3F;
 Thu, 12 Aug 2021 08:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628758744;
 bh=8mYYilhUDGBXxNyWqQd1m1A2djqb4Kt850ntLHj3+nM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cB3WXrqd2g2o2zLlMVgOof5kb6v2wUXjrmPiRTDMJAG6qx2L45YQlz5w+2UVzNNip
 d40do10DEn9Xht7JKb3ZXJitrqiu5j7dpfeR46IK6OyMAc+t5LjyJz/nitneMzOQ1q
 dJ/aimBjHaXS65TgwT2SbRa9NcBUs9p9E0WdPaRkS+OyiFSd3CseSTAsaFkOCh9Pyb
 AsP0Zwhr+7PbLUQ9X2mMqaFW7/hH4vvXD+jZDaASFKPYd4xmcWN47nDZ5D97XDTnN+
 aW0rqHhx9b4YdJ02zfBJbQRECQk/qV++h0er6pbNvim0F1vEAZpjz/LIuHGc0r8Yga
 ocOZPiukOqkHQ==
Date: Thu, 12 Aug 2021 09:58:58 +0100
From: Will Deacon <will@kernel.org>
To: Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 01/15] KVM: arm64: placeholder to check if VM is
 protected
Message-ID: <20210812085857.GB5912@willie-the-truck>
References: <20210719160346.609914-1-tabba@google.com>
 <20210719160346.609914-2-tabba@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210719160346.609914-2-tabba@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu,
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

On Mon, Jul 19, 2021 at 05:03:32PM +0100, Fuad Tabba wrote:
> Add a function to check whether a VM is protected (under pKVM).
> Since the creation of protected VMs isn't enabled yet, this is a
> placeholder that always returns false. The intention is for this
> to become a check for protected VMs in the future (see Will's RFC
> [*]).
> 
> No functional change intended.
> 
> Signed-off-by: Fuad Tabba <tabba@google.com>
> 
> [*] https://lore.kernel.org/kvmarm/20210603183347.1695-1-will@kernel.org/

You can make this a Link: tag.

Anyway, I think it makes lots of sense to decouple this from the user-ABI
series:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
