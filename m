Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E01691C381C
	for <lists+kvmarm@lfdr.de>; Mon,  4 May 2020 13:31:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 62AA44B39C;
	Mon,  4 May 2020 07:31:01 -0400 (EDT)
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
	with ESMTP id 7C+cAAa8S2ae; Mon,  4 May 2020 07:31:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 482384B39E;
	Mon,  4 May 2020 07:31:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A7D04B399
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 May 2020 07:30:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gxw7YDs15Iq1 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  4 May 2020 07:30:58 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 65C984B397
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 May 2020 07:30:58 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 44F3D2073E;
 Mon,  4 May 2020 11:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588591857;
 bh=VZLtzlcQTt1eJsb0z5+z2NjKOOqUX3h5X2JO4zv9pDo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2OhI4xd+rijq0aBcmEM/iBxzF5t4ZID7LjsEROOxJ3U+rl8zzzZODfvwMGpGOIVOU
 hyTIJfu0kwTZZqy5wn/cm2xQcjZSwI8zFeAX/Cml8tlVeHtrwun8MrVVhu0ozgFYpj
 OhL5v6lGFQghRa1mpUK69u+KkaktGLi9EQgJ7HiM=
Date: Mon, 4 May 2020 12:30:52 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>, pbonzini@redhat.com
Subject: Re: [GIT PULL] KVM/arm fixes for 5.7, take #2
Message-ID: <20200504113051.GB1326@willie-the-truck>
References: <20200501101204.364798-1-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200501101204.364798-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, Fangrui Song <maskray@google.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
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

Hi Marc, Paolo,

On Fri, May 01, 2020 at 11:12:00AM +0100, Marc Zyngier wrote:
> This is the second batch of KVM/arm fixes for 5.7. A compilation fix,
> a GICv4.1 fix, plus a couple of sanity checks (SP_EL0 save/restore,
> and the sanitising of AArch32 registers).
> 
> Note that the pull request I sent a week ago[1] is still valid, and
> that this new series is built on top of the previous one.
> 
> Please pull,

I don't see this queued up in the kvm tree, which appears to have been
sitting dormant for 10 days. Consequently, there are fixes sitting in
limbo and we /still/ don't have a sensible base for arm64/kvm patches
targetting 5.8.

Paolo -- how can I help get this stuff moving again? I'm more than happy
to send this lot up to Linus via arm64 if you're busy atm. Please just
let me know.

Cheers,

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
