Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC6948AB4A
	for <lists+kvmarm@lfdr.de>; Tue, 11 Jan 2022 11:23:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C97E04B228;
	Tue, 11 Jan 2022 05:23:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pzSyXi-wcp7p; Tue, 11 Jan 2022 05:23:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 98BDA4B1E6;
	Tue, 11 Jan 2022 05:23:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D3E014B1E6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jan 2022 05:23:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IxNvT0agHdZP for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Jan 2022 05:23:51 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8CCC24B1AF
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jan 2022 05:23:51 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 51E80B819CD;
 Tue, 11 Jan 2022 10:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6E5C36AE9;
 Tue, 11 Jan 2022 10:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641896629;
 bh=rLjD10oD9rqTVqIwpiJZNWSMQasAD9/0XTaE7F0fPJM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TCU5mDKO7IVKoA6t1LM1XXUwtnRWErJZiM8V0rm9W6W0dOtlo41/6ao7AGeXG6DWo
 a3CxPbUcMDKNUwEY98ghskIzMQPGU7aODjowexlxLse7uqek8kjj9w1eVbJMObl7ji
 LoFBKsAtgbNkMqkZa3s6WlU4x0cuTdHeuSFSipv1kCrt9Un4m5uAyE75Rao/HMaypl
 1gkfZz2BzJRRtkUwMKw4ZCHSn0dnLIDFvx5UObh7bUWcBzYA3e1wMP4/kKZeY6wuVz
 hCIenB7SZQHvNn7XAZ6T9+r+cPcFA+bnHnurRrlsYdfgYWHb7NOWIlY6Ubun7FPivZ
 SZHKTUH9gOKFw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1n7EJf-00HM32-2U; Tue, 11 Jan 2022 10:23:47 +0000
Date: Tue, 11 Jan 2022 10:23:46 +0000
Message-ID: <87bl0itvt9.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Jing Zhang <jingzhangos@google.com>
Subject: Re: [RFC PATCH 1/3] KVM: arm64: Use read/write spin lock for MMU
 protection
In-Reply-To: <20220110210441.2074798-2-jingzhangos@google.com>
References: <20220110210441.2074798-1-jingzhangos@google.com>
 <20220110210441.2074798-2-jingzhangos@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: jingzhangos@google.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, will@kernel.org, pbonzini@redhat.com,
 dmatlack@google.com, oupton@google.com, reijiw@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: KVM <kvm@vger.kernel.org>, David Matlack <dmatlack@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 KVMARM <kvmarm@lists.cs.columbia.edu>
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

On Mon, 10 Jan 2022 21:04:39 +0000,
Jing Zhang <jingzhangos@google.com> wrote:
> 
> To reduce the contentions caused by MMU lock, some MMU operations can
> be performed under read lock.
> One improvement is to add a fast path for permission relaxation during
> dirty logging under the read lock.

This commit message really doesn't say what this patch does
(converting our MMU spinlock to a rwlock, and replacing all instances
of the lock being acquired with a write lock acquisition). Crucially,
it only mention the read lock which appears *nowhere* in this patch.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
