Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A7E1B3806EB
	for <lists+kvmarm@lfdr.de>; Fri, 14 May 2021 12:09:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 25F844B974;
	Fri, 14 May 2021 06:09:50 -0400 (EDT)
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
	with ESMTP id rdKjBkn3ecdy; Fri, 14 May 2021 06:09:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1017A4B96B;
	Fri, 14 May 2021 06:09:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7715C4B5D0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 May 2021 06:09:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L0JKUelxCxsJ for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 May 2021 06:09:47 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8BA2A4B4E1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 May 2021 06:09:47 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5CAC613DE;
 Fri, 14 May 2021 10:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620986985;
 bh=rsi3ZhbJrV1dWUbSH/SkWRsfeNX8nDeKeUti9eHUG2E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dyCUKdvpFYsOoZXCCc1XWfMkQWpYXOSZCTTwcpY4JNVN4xCeJkme3p9CSVUvxBZ1P
 nNenKgUlGe9c7C6bZanugAz/ZvVuu7VIYW6L0ygnjLCQMC7iGKjfbHJ7wvk64RAdxL
 zYB1kmaeQHAylTchcX2bryrT0y0zfo/fv0nuPJSiXc0QQAdOXUyIYH8NiarbCUnIQG
 H04ORN2MNptoED+At4yCPCK2z5tkiubRlPgfQF+oFzTdxV5SE9duwkaNfYhFajNOB2
 yiR7GRYJiH7FQNC/+nrK8A0gEX0a/9tkMkelDY902Tl69KbLZCJDl3DqZogoV53Vsl
 7epi6OzeDoPnA==
Date: Fri, 14 May 2021 11:09:41 +0100
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH 2/2] KVM: arm64: Mark the host stage-2 memory pools static
Message-ID: <20210514100941.GA3795@willie-the-truck>
References: <20210514085640.3917886-1-qperret@google.com>
 <20210514085640.3917886-3-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210514085640.3917886-3-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: maz@kernel.org, kbuild-all@lists.01.org, kvmarm@lists.cs.columbia.edu
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

On Fri, May 14, 2021 at 08:56:40AM +0000, Quentin Perret wrote:
> The host stage-2 memory pools are not used outside of mem_protect.c,
> mark them static.
> 
> Fixes: 1025c8c0c6ac ("KVM: arm64: Wrap the host with a stage 2")
> Reported-by: Reported-by: kernel test robot <lkp@intel.com>

^^^ nit, but this tag has gone wonky.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
