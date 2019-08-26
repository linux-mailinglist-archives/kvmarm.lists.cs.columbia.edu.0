Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C218E9CC68
	for <lists+kvmarm@lfdr.de>; Mon, 26 Aug 2019 11:18:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 587CC4A5BF;
	Mon, 26 Aug 2019 05:18:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oY08S8XEH9Xg; Mon, 26 Aug 2019 05:18:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 15A084A5B8;
	Mon, 26 Aug 2019 05:18:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B3D54A58D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Aug 2019 05:18:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2MK2C12N4aep for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Aug 2019 05:18:13 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A3434A568
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Aug 2019 05:18:12 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DC111570;
 Mon, 26 Aug 2019 02:18:12 -0700 (PDT)
Received: from big-swifty.misterjones.org (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E865A3F59C;
 Mon, 26 Aug 2019 02:17:27 -0700 (PDT)
Date: Mon, 26 Aug 2019 10:17:22 +0100
Message-ID: <86sgpomgkd.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/2] kbuild: change *FLAGS_<basetarget>.o to take the path
 relative to $(obj)
In-Reply-To: <20190825172833.5708-1-yamada.masahiro@socionext.com>
References: <20190825172833.5708-1-yamada.masahiro@socionext.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 EasyPG/1.0.0 Emacs/26
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Organization: Approximate
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Cc: x86@kernel.org, Michal Marek <michal.lkml@markovi.net>,
 linux-kbuild@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, kvmarm@lists.cs.columbia.edu
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

On Sun, 25 Aug 2019 18:28:32 +0100,
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> 
> Kbuild provides per-file compiler flag addition/removal:
> 
>   CFLAGS_<basetarget>.o
>   CFLAGS_REMOVE_<basetarget>.o
>   AFLAGS_<basetarget>.o
>   AFLAGS_REMOVE_<basetarget>.o
>   CPPFLAGS_<basetarget>
>   HOSTCFLAGS_<basetarget>.o
>   HOSTCXXFLAGS_<basetarget>.o
> 
> The <basetarget> is the filename of the target without its suffix.
> 
> This syntax comes into a trouble when two files with the same name
> appear in one Makefile, for example:
> 
>   obj-y += foo.o
>   obj-y += dir/foo.o
>   CFLAGS_foo.o := <some-flags>
> 
> Here, the <some-flags> applies to both foo.o and dir/foo.o
> 
> The real world problem is:
> 
>   scripts/kconfig/util.c
>   scripts/kconfig/lxdialog/util.c
> 
> Both files are compiled into scripts/kconfig/mconf, but only the
> latter should be given with additional flags for ncurses.
> 
> It is more sensible to use the relative path to the Makefile, like this:
> 
>   obj-y += foo.o
>   CFLAGS_foo.o := <some-flags>
>   obj-y += dir/foo.o
>   CFLAGS_dir/foo.o := <other-flags>
> 
> The $* variable is replaced with the stem ('%') part in a pattern rule.
> In other words, this only works for pattern rules.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/kvm/Makefile        |  5 +++--
>  arch/x86/entry/vdso/Makefile |  3 ++-
>  scripts/Makefile.host        | 30 +++++++++++++++---------------
>  scripts/Makefile.lib         | 10 +++++-----
>  scripts/kconfig/Makefile     |  8 ++++----
>  5 files changed, 29 insertions(+), 27 deletions(-)

For the KVM/arm part:

Acked-by: Marc Zyngier <maz@kernel.org>

Thanks,

	M.

-- 
Jazz is not dead, it just smells funny.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
