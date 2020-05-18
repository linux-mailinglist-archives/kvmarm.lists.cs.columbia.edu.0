Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 549511D7EDD
	for <lists+kvmarm@lfdr.de>; Mon, 18 May 2020 18:44:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E62584B162;
	Mon, 18 May 2020 12:44:17 -0400 (EDT)
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
	with ESMTP id LZJtrPB0LV-b; Mon, 18 May 2020 12:44:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DAA134B161;
	Mon, 18 May 2020 12:44:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 139F84B14F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 May 2020 12:44:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OxpsGZ6KTPm6 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 18 May 2020 12:44:15 -0400 (EDT)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 202E14B0ED
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 May 2020 12:44:15 -0400 (EDT)
Received: by mail-wm1-f68.google.com with SMTP id m185so234420wme.3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 May 2020 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=mrOVKHVJapH6kF5qReOp0wglPtw6uXIPRlbofv8HkOI=;
 b=nSW/zmI+oIKzyOLNG6etkGbyYqHBBsA2N8whXlXs5aLplRWbKVRVZJuGjkipitkMFd
 JpDvh6n1I6fl6OnyDNwsPT/olbSNWIvVDkOpC9T4/wi31U2gZWWAb9vaKvbqwiXWSzRE
 /OCEBdRmoFd+eNbb5XCzC9mXeGwdFmBqmUkmzBgIlhfo5zWNUwJ7+xhAVSwwqpiTwxhR
 YbwDxXTWPeNSRUpgsH2ZgBcUrvqn70knzY40sUTMnYGSikYPo9uylu89drqXy985LCES
 jwguU3GVWDkHvHwoJhoQ2HH/fA+IMRHX4PXEy9HH7+Dn53Y38W//jL36zKm6iMSn9XTQ
 JH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mrOVKHVJapH6kF5qReOp0wglPtw6uXIPRlbofv8HkOI=;
 b=ILWUAhFd4ESZ3Q72QzDXAHjDI0jzebIpQH+Zt/oBYpoRqnrdYu2AJQhgdAu6ryPSFB
 D0G3j4BD9/bTsxLGp0lWIi24ciHPFp+OlbEPIs6S47W/aH4zyqq7XJ+X9ZNz8dq7u0uj
 a9Tiz0H2O1iHxUQgQATDwzJ815YLgvNOyblGEBfp9TAWJ7tyl3EeQCOfFIh00MPEzoNG
 Ut9EEvzHDePkE4POrm8kfIGLyLvXZYJFQw44HkNQuWWBdbnLFWgm+2+0/bXyW3kgcOmJ
 S30zAQWi1rHA+X5OBVcPCB8olysxdysEmf8eitQSCl5CFGidCoW80DsDaBBJ0fRGtyQr
 ii5A==
X-Gm-Message-State: AOAM532tludFezcSjQpA3yVnbMB9/fVedqaBOYAFytrYlKhYrlRV6wZJ
 uPbqSPDa4z5zk5vY+fvldCTk0Q==
X-Google-Smtp-Source: ABdhPJxvMfrufurokRmF+O8ESaZRzfiwWThU1ZHkuIFz5YhCwG7DhnQCN+0EO7FHTPHDCdOSTcYLjg==
X-Received: by 2002:a1c:2e4d:: with SMTP id u74mr230711wmu.145.1589820253760; 
 Mon, 18 May 2020 09:44:13 -0700 (PDT)
Received: from dbrazdil-macbookpro.roam.corp.google.com
 ([2a01:4b00:8523:2d03:4431:2de6:16f:7f90])
 by smtp.gmail.com with ESMTPSA id e21sm125834wme.34.2020.05.18.09.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 09:44:13 -0700 (PDT)
From: David Brazdil <dbrazdil@google.com>
X-Google-Original-From: David Brazdil
 <dbrazdil@dbrazdil-macbookpro.roam.corp.google.com>
Date: Mon, 18 May 2020 17:44:12 +0100
To: Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v2 07/14] arm64: kvm: Split hyp/switch.c to VHE/nVHE
Message-ID: <20200518164412.coycmliijagaaw4m@dbrazdil-macbookpro.roam.corp.google.com>
References: <20200515105841.73532-1-dbrazdil@google.com>
 <20200515105841.73532-8-dbrazdil@google.com>
 <20200518152851.GA147668@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200518152851.GA147668@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

On Mon, May 18, 2020 at 04:28:51PM +0100, Andrew Scull wrote:
> On Fri, May 15, 2020 at 11:58:34AM +0100, David Brazdil wrote:
> > +__kvm_nvhe_sve_load_state = sve_load_state;
> > +__kvm_nvhe_sve_save_state = sve_save_state;
> 
> Building without CONFIG_ARM64_VHE leads to a linker error due to the SVE
> functions being referenced in this list. This is caused by
> CONFIG_ARM64_VHE disabling CONFIG_ARM64_SVE and, in turn, preventing the
> generation of those symbols. There aren't any references from code, just
> this file.
> 
> It can be resolved by having the SVE symbol aliases depend on
> CONFIG_ARM64_SVE.
Thanks, will fix the linker script in v3.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
