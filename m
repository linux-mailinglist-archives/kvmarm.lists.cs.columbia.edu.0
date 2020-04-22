Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 23F511B4BD8
	for <lists+kvmarm@lfdr.de>; Wed, 22 Apr 2020 19:36:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 90DAA4B1A4;
	Wed, 22 Apr 2020 13:36:21 -0400 (EDT)
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
	with ESMTP id 7QgSqLNvAHew; Wed, 22 Apr 2020 13:36:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 95BC14B1A7;
	Wed, 22 Apr 2020 13:36:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C19AE4B1A3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Apr 2020 13:36:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gK+IO5J17gMz for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Apr 2020 13:36:17 -0400 (EDT)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 97FCE4B1A1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Apr 2020 13:36:17 -0400 (EDT)
Received: by mail-wm1-f65.google.com with SMTP id z6so3434845wml.2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Apr 2020 10:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=VqYLYOfHT5ZSfKGRKS+ZrdUHUhuXAoIInHJ1yfB851Y=;
 b=W/LNCjGmYpNRINFjSz7yKOY0zNA9BTF14QsDEQB01oevDc/GgPPxVzDSTvjG5gAhbV
 esimCCSQioFWbimMAYRRg/+5XjJVBd4qoZ06SOLlH0iKUcf9v5215MbqLXeahWJQDmrb
 hVp4JLkHfntCQUcB6Pm658ohlphmO0GTEYu0wK9ViUhPP1aWmjMNK440lifjPRQbhKVk
 qMxzSRoYTeiGRqdrpS7z2iYOZkwPprMW95EAhoxXlWa0Pfeh+nChyDrKKeLV2UAyUAA7
 8UaA1p2+vXq2g6zH7Ac3fdTYLn+QRzYnGjXbvIG5Tb2dCJRrmUQCAtbr3aTrzonNS9ae
 TZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VqYLYOfHT5ZSfKGRKS+ZrdUHUhuXAoIInHJ1yfB851Y=;
 b=QZruH0Gs/94tgEJk+2UbAXCNxeHeidqh/oDnWOqNU06E5hKF6cERzDfRa/rHYKDB76
 NxGTXPfD3ajASVwZg5vLoc2I1yzGxPAmMNfOTEJOWl1Lui0R6Bg+XZOMCcOiSUW8LYvR
 cFyj09kixqsV0xn/8rmlR7bOwBr9PrHYvQ3uyapW+LHvqf8EvNjQ6NbgCDpCJqrqkO3Y
 9EXC/AHWJmA+OpBL9ZU7xPdxQndDoT9GRpI/4iGoxtPCB9akR6CwNXsKEiuJ8MoOegZb
 CfqXB5gN8tazDEs+c+Wtbq8CTvuJqrJXZRK0ck+/wfjEcjZW8vyv496fvGQ3aRiGTU34
 l/jQ==
X-Gm-Message-State: AGi0PuYUnugrNaMjw88nT3kx5iHGBNhbSRxE+jm3fEQwqWiQWPFNMnoF
 q95gDMdr6mvJRdz84NGkfHrWkcOzZks=
X-Google-Smtp-Source: APiQypKPIJqGIiMFYHYI6SdYXapZap4vIILlRn2L4aANn4NELzJ8fw67xU/T5bMViFaJ25gGtDH03g==
X-Received: by 2002:a1c:a5c8:: with SMTP id o191mr12048574wme.77.1587576975999; 
 Wed, 22 Apr 2020 10:36:15 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:109:355c:447d:ad3d:ac5c])
 by smtp.gmail.com with ESMTPSA id p7sm9473270wrf.31.2020.04.22.10.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 10:36:15 -0700 (PDT)
Date: Wed, 22 Apr 2020 18:36:10 +0100
From: Andrew Scull <ascull@google.com>
To: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Unify WORKAROUND_SPECULATIVE_AT_{NVHE,VHE}
Message-ID: <20200422173610.GA115208@google.com>
References: <20200422161346.67325-1-ascull@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200422161346.67325-1-ascull@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
 Will Deacon <will@kernel.org>
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

On Wed, Apr 22, 2020 at 05:13:46PM +0100, Andrew Scull wrote:
> * From v1 <20200327143941.195626-1-ascull@google.com>:
>   - Restored registers in VHE path
>   - RFC: Remove trust in host

Woops, got a bit happy with my clipboard. That last point isn't included
here as it didn't seem totally relevant. This patch is just fixing up
v1.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
