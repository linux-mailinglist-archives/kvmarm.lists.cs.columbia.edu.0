Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0501D32F362
	for <lists+kvmarm@lfdr.de>; Fri,  5 Mar 2021 20:02:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7CD094B6B9;
	Fri,  5 Mar 2021 14:02:16 -0500 (EST)
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
	with ESMTP id kPPa5t18ln3b; Fri,  5 Mar 2021 14:02:16 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C0834B6BB;
	Fri,  5 Mar 2021 14:02:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 15EE14B69B
 for <kvmarm@lists.cs.columbia.edu>; Fri,  5 Mar 2021 14:02:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pa5LJ4XoaVNi for <kvmarm@lists.cs.columbia.edu>;
 Fri,  5 Mar 2021 14:02:13 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2DE6A4B697
 for <kvmarm@lists.cs.columbia.edu>; Fri,  5 Mar 2021 14:02:13 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43CA96509A;
 Fri,  5 Mar 2021 19:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614970932;
 bh=+HY4tyg5MEsNmrtevimpEfoDy4PsjuAzV42+G/FLMVQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c0cXkUhfqGyQIPH14jJKrVOWqS+nkTdjAw7+FncqA/3JiGVSK+/buLmQR5CPX0Lkh
 dCW7dcorA8Yx48N9S2h9g8R6GdPZXZYvGcN7K0Y5c7YEU2XCqb+THvNf39KKmGJPvg
 7SlguW8KOncXG2JrcnBGVpunFHsss2GoyrMFKsQFZP5J3xQ2z4EDXBStFAxnJPxUzg
 aey5TwsRQzPpuo0eVRH2m/iUb2g8ydUomIz9TElX1hpK5ZM3qVToNjiQU/XknJ3DEC
 KaxOe0sr57aCvtJqjnsfjIielTW4HTsR6GLfySdzgt5AgvwD20BCAzORpz6fubBLwx
 lvJZ9Wwx+U9Wg==
Date: Fri, 5 Mar 2021 19:02:06 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v3 31/32] KVM: arm64: Disable PMU support in protected mode
Message-ID: <20210305190205.GA23633@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-32-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-32-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: android-kvm@google.com, catalin.marinas@arm.com, mate.toth-pal@arm.com,
 seanjc@google.com, tabba@google.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

On Tue, Mar 02, 2021 at 03:00:01PM +0000, Quentin Perret wrote:
> The host currently writes directly in EL2 per-CPU data sections from
> the PMU code when running in nVHE. In preparation for unmapping the EL2
> sections from the host stage 2, disable PMU support in protected mode as
> we currently do not have a use-case for it.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/perf.c | 3 ++-
>  arch/arm64/kvm/pmu.c  | 8 ++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
