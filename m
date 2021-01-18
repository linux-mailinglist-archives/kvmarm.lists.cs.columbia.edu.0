Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF02FA3B0
	for <lists+kvmarm@lfdr.de>; Mon, 18 Jan 2021 15:54:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6F7D24B2CC;
	Mon, 18 Jan 2021 09:54:41 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DAiNmQDhf3YH; Mon, 18 Jan 2021 09:54:41 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4303E4B2A2;
	Mon, 18 Jan 2021 09:54:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9EBF44B29D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Jan 2021 09:54:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xo1JififZFlM for <kvmarm@lists.cs.columbia.edu>;
 Mon, 18 Jan 2021 09:54:37 -0500 (EST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6C4834B26D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Jan 2021 09:54:37 -0500 (EST)
Received: by mail-wm1-f43.google.com with SMTP id i63so13849966wma.4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Jan 2021 06:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=bJKOCIhgp2n2XDRcM4f1+mhwqcxWdVNau3p3HbDQCsQ=;
 b=KbFMIpZl8sxRjKqORQuoy0bbEKHAsIFWrTPauw8EWR0jhNuKKZEGP/zuqK95fjHeX/
 lFy76l4st/jJl3GWQDDUSj2JYqxUIHVU9VRmQcZlyNZW8NJ4hhnbH8k6hmZZXx/RWHV/
 7odDwx25iRfazRG0bagwmgXkvV5SkjJANBw0UVpp3gK1N+OeDB23LZe86HKnhHty0Wzv
 Z90YdryTRsnJzyCLcR3y6v4Ig56vmt9IwH6Umd977izSVciVE1zIofrC+O1VJERXB6iY
 pPUmwZmH7jOF3CZ8y1xi9a1O3lJXkSKdOCbPhBlkpdS05RAITTywf3lujT4zteEEBY++
 Go0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bJKOCIhgp2n2XDRcM4f1+mhwqcxWdVNau3p3HbDQCsQ=;
 b=YCTrIbZ87yi65KOAypwDbhleZJCW77Sl8ZpLYyvKdrQGel/4hZZeOANrH8BpUa8FbL
 xspET/AIbN1/rmLhIJDYGN4Nhv4X+5Nj0hzArcYb6EpSS5nBSKaDNwEktQgB2Y5LhDIL
 T5USvDnRb/BxVLB94CAdDsxqDHQKyatQ6/PLhGm83jtD7PpcFn3JP2SE4fboFIJUgeA7
 nLwECrENWJhcZw7atniqL5qy0/0DL74eVxlN+nd9I0oJDbDWkd6zeGTYFioimjUAZMwa
 oqW5YeAM6RnMDC4Fvezhx9THJnKHXJW0Emw2MjHN0d/uByxu/5eNhc416pJxyd7YWEWz
 vFpA==
X-Gm-Message-State: AOAM5334CYsPEIorAAfb1HivC0s/z/i0m2du7ZKoP7EF5f9PAtVsjo/K
 TrCg1VTDm3B1w5HWBNWV2zpt4w==
X-Google-Smtp-Source: ABdhPJz6bW3BGvz8nTjOKnqiVeRy9unK18MMh2g7waN9oE7GE7k4Wvz87vgOhlNoIs3aMnmGr/BJ+Q==
X-Received: by 2002:a1c:6a02:: with SMTP id f2mr21519184wmc.36.1610981676034; 
 Mon, 18 Jan 2021 06:54:36 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:3d4d:985d:87b7:4d55])
 by smtp.gmail.com with ESMTPSA id h125sm12879816wmh.16.2021.01.18.06.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 06:54:35 -0800 (PST)
Date: Mon, 18 Jan 2021 14:54:34 +0000
From: David Brazdil <dbrazdil@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 00/21] arm64: Early CPU feature override, and
 applications to VHE, BTI and PAuth
Message-ID: <20210118145434.2lar7xkgwy5yj54i@google.com>
References: <20210118094533.2874082-1-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-1-maz@kernel.org>
Cc: kernel-team@android.com, Srinivas Ramana <sramana@codeaurora.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Ajay Patil <pajay@qti.qualcomm.com>,
 Prasad Sodagudi <psodagud@codeaurora.org>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Mon, Jan 18, 2021 at 09:45:12AM +0000, Marc Zyngier wrote:
> It recently came to light that there is a need to be able to override
> some CPU features very early on, before the kernel is fully up and
> running. The reasons for this range from specific feature support
> (such as using Protected KVM on VHE HW, which is the main motivation
> for this work) to errata workaround (a feature is broken on a CPU and
> needs to be turned off, or rather not enabled).
> 
> This series tries to offer a limited framework for this kind of
> problems, by allowing a set of options to be passed on the
> command-line and altering the feature set that the cpufeature
> subsystem exposes to the rest of the kernel. Note that this doesn't
> change anything for code that directly uses the CPU ID registers.
> 
> The series completely changes the way a VHE-capable system boots, by
> *always* booting non-VHE first, and then upgrading to VHE when deemed
> capable. Although it sounds scary, this is actually simple to
> implement (and I wish I had done that five years ago). The "upgrade to
> VHE" path is then conditioned on the VHE feature not being disabled
> from the command-line.
> 
> Said command-line parsing borrows a lot from the kaslr code, and
> subsequently allows the "nokaslr" option to be moved to the new
> infrastructure (though it all looks a bit... odd).
> 
> Further patches now add support for disabling BTI and PAuth, the
> latter being based on an initial series by Srinivas Ramana[0]. There
> is some ongoing discussions about being able to disable MTE, but no
> clear resolution on that subject yet.
> 
> This has been tested on multiple VHE and non-VHE systems.
> 
> * From v3 [3]:
>   - Fixed the VHE_RESTART stub (duh!)
>   - Switched to using arm64_ftr_safe_value() instead of the user
>     provided value
>   - Per-feature override warning
> 
> * From v2 [2]:
>   - Simplify the VHE_RESTART stub
>   - Fixed a number of spelling mistakes, and hopefully introduced a
>     few more
>   - Override features in __read_sysreg_by_encoding()
>   - Allow both BTI and PAuth to be overridden on the command line
>   - Rebased on -rc3
> 
> * From v1 [1]:
>   - Fix SPE init on VHE when EL2 doesn't own SPE
>   - Fix re-init when KASLR is used
>   - Handle the resume path
>   - Rebased to 5.11-rc2
> 
> [0] https://lore.kernel.org/r/1610152163-16554-1-git-send-email-sramana@codeaurora.org
> [1] https://lore.kernel.org/r/20201228104958.1848833-1-maz@kernel.org
> [2] https://lore.kernel.org/r/20210104135011.2063104-1-maz@kernel.org
> [3] https://lore.kernel.org/r/20210111132811.2455113-1-maz@kernel.org

Pretty cool! Left a few minor comments here and there, other than that:
Acked-by: David Brazdil <dbrazdil@google.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
