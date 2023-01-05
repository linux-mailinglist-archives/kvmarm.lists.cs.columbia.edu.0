Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 44C6765F77D
	for <lists+kvmarm@lfdr.de>; Fri,  6 Jan 2023 00:10:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 82BF64B349;
	Thu,  5 Jan 2023 18:10:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.787
X-Spam-Level: 
X-Spam-Status: No, score=-1.787 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ww9BPZYgmWQh; Thu,  5 Jan 2023 18:10:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D8EB4B2F1;
	Thu,  5 Jan 2023 18:10:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3510B4A0DA
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Jan 2023 18:10:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FQsMwElw2vGa for <kvmarm@lists.cs.columbia.edu>;
 Thu,  5 Jan 2023 18:10:00 -0500 (EST)
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com
 [209.85.166.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0FF4A4B28D
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Jan 2023 18:09:59 -0500 (EST)
Received: by mail-il1-f202.google.com with SMTP id
 h24-20020a056e021d9800b0030be8a5dd68so74921ila.13
 for <kvmarm@lists.cs.columbia.edu>; Thu, 05 Jan 2023 15:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BJsdUMLhEk3aA5AR63amzEBOGfmfBjYGxSuk8c1Qt10=;
 b=VQLWKo+2MehS6AsR9h36jKmvEqgx8CfuLM1Oq6rLI52ExnNXJFmc0zJPWsPxjuP1nn
 mnlAUf8c8ESCTKaHej192XSR4B89hSSe8lX7p+VaSH0DVwXUnPzTkNtHVhERIbH55qT7
 3iFRCJyH1mdCN2++m65/ncRnbUe+FYgncyR9N3fSblJS0PWNtKG4DIwOYM8yCR0CG50W
 QZObrqLpWq0LQJ1jtxnjYTmspt2bkbmSPBtN5qRs6VLLm13yL46RT+fMvukvzBPL3vzJ
 gJDutVo4fuDvx0TWGdJNzyfcQAa5t2gzWmBABn0wKprOkUQD7Sl9ARlSdRLtoos0FPOP
 bYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BJsdUMLhEk3aA5AR63amzEBOGfmfBjYGxSuk8c1Qt10=;
 b=19a5uSMMRu7FkWjvO9jy67muSINkfbME0Air6KhdDOe7iRatPlQN8TF/OjtvJPjsed
 cjJsF3Y8YepRTJUecT0rhUlp7ApOXJdbmAQpeQ0GjpbvYtxyECV/w7C4TlctqVmpkZty
 wXvwcknHVd1evii+Ur0mVscVvd1Oc2GvTEXSHLF9SXHueBw2rnGLG+paB41SL0rMpgMl
 753FN0GAFTrRXxc8YFwGAVgcIVKV3uMeD3wr6xQa2P3PMfZ5lZczpP4nZbAOUe2E3xCY
 o+u0Bu8CRkQeHQnGzDI0oXkEht9xkMIBtlKE4A+DWDGg+aSBXOLZJ3IOzMsVrV/33a8C
 auTw==
X-Gm-Message-State: AFqh2kqFrL3j6u9mJBoqtUQU2G5uyed86bDJ7bavR1WXe3l32zzGh0Ry
 rxH3Zk2GWKF+hHnq/OAjc3/EePLN0WNEq01xcA==
X-Google-Smtp-Source: AMrXdXusCD1V0Xxvg9B1dqcZLnzpK4NBbPWqXPd4CP3y5CmOXzVmCp5f2JJBo69qjfDNKGWxDtZwmq7nwqgXTB9Meg==
X-Received: from coltonlewis-kvm.c.googlers.com
 ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6638:27c:b0:38a:757f:14b4 with
 SMTP id x28-20020a056638027c00b0038a757f14b4mr4660013jaq.307.1672960199428;
 Thu, 05 Jan 2023 15:09:59 -0800 (PST)
Date: Thu, 05 Jan 2023 23:09:58 +0000
In-Reply-To: <20221226182158.3azk5zwvl2vsy36h@orel> (message from Andrew Jones
 on Mon, 26 Dec 2022 19:21:58 +0100)
Mime-Version: 1.0
Message-ID: <gsntzgawr321.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [kvm-unit-tests PATCH] arm: Remove MAX_SMP probe loop
From: Colton Lewis <coltonlewis@google.com>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: kvm@vger.kernel.org, maz@kernel.org, kvmarm@lists.cs.columbia.edu
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Andrew Jones <andrew.jones@linux.dev> writes:
> On Tue, Dec 20, 2022 at 04:32:00PM +0000, Colton Lewis wrote:
>> Alexandru Elisei <alexandru.elisei@arm.com> writes:
> Ah, I think I understand now. Were you running 32-bit arm tests? If so,
> it'd be good to point that out explicitly in the commit message (the
> 'arm:' prefix in the summary is ambiguous).

No, this was happening on arm64. Since it had been a while since I noted
this issue, I reviewed it and realized the issue was only happening
using -accel tcg. That was automatically being used on my problem test
machine without me noticing. That's where the limit of 8 seems to be
coming from and why the loop is triggered.

qemu-system-aarch64: Number of SMP CPUs requested (152) exceeds max CPUs  
supported by machine 'mach-virt' (8)

Since this case doesn't directly involve KVM, I doubt anyone cares about
a fix.

> Assuming the loop body was running because it needed to reduce MAX_SMP to
> 8 or lower for 32-bit arm tests, then we should be replacing the loop with
> something that caps MAX_SMP at 8 for 32-bit arm tests instead.

We could cap at 8 for ACCEL=tcg. Even if no one cares, I'm tempted to do
it so no one hits the same little landmine as me in the future.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
