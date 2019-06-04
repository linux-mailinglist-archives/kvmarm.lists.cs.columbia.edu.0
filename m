Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AD1C334207
	for <lists+kvmarm@lfdr.de>; Tue,  4 Jun 2019 10:40:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 322C34A4E9;
	Tue,  4 Jun 2019 04:40:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GKQaCa9x22HB; Tue,  4 Jun 2019 04:40:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 151394A4CA;
	Tue,  4 Jun 2019 04:40:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 296704A3B4
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 04:40:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LDGaeJ+F54LV for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Jun 2019 04:39:58 -0400 (EDT)
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 225234A319
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 04:39:58 -0400 (EDT)
Received: by mail-pl1-f193.google.com with SMTP id s24so7919294plr.8
 for <kvmarm@lists.cs.columbia.edu>; Tue, 04 Jun 2019 01:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9jjhf1qdL2MafkChBuP3uS+RTNrDWf6uQ5f116KCA2c=;
 b=R/1BYv8OoEAUiLPx6NI4JKkrBSSi/SSZ5etYBe7bvAN6vIDmwNO+lHDRdqjVBNQjin
 H+9WJUbycCX09ft7jeo1RwSbBmS/JbGjhw2h0nRODdNdmH2j8+p3X5/IqSREmbTVYdKh
 jYtr0D6CiWKVJUltZDsvR7Li9ljJdTLEdRCN5BAtnMAw5NgyzB/DuLTgAPN63NPEUBGG
 oyiGOxYJMfgKa5dqaxEUCGya8yjW1QQeKvcqk8RrenqYLcWWqMxyupGv5nxxmdXsdigZ
 8blPkPcHVDXb3yCSelTiJssCWLyxfOWrMfblAEJgCmw7bgfdpkELrwDmK6oQxpemZ4Wi
 6nGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9jjhf1qdL2MafkChBuP3uS+RTNrDWf6uQ5f116KCA2c=;
 b=ku1AbaUyMaf4kRx6uDVKmSmnpHBZDYbT7Klg9sbkvm9C6QAbZE22DOLnY8+u+6y/Cm
 8rJ5usavSa8xu1NBxnDq1tO0+0gDcQnj30RfxaCdQM7RRJIVL7oKG2h30zxsW+tktAJR
 E5Pjntdcz/ZHZcvporqAd9spx6R+G+cwty5+0SR2H14tpB6/d1z8tcULNHTtQ52R0Eep
 NyAArjBC7/Fdrc8i5JCyXjJnzrewFpZcnZH3Ii5o+HzLQ+iD6AroAYVWsAYeOAO9ad36
 EDOIaUcsAwLT5o4NqmMkno69Zx333N5aw028Wghv3oras0HILxQ6BTdGTvKdeOESJ1Rc
 AXQA==
X-Gm-Message-State: APjAAAUR9IUMfhzOoDGEpLrEfpdxlLHQOIone4XiFsWKS/O+pqi9UU/A
 GCBg570DiLBKATs68Fj8kZlLVg==
X-Google-Smtp-Source: APXvYqwTQEAPd18gZqeEmzC2WFCpS0mvDpNCW4MkbXVyYBl0A48wQeEqLgL0pHs3OD8tbWfxvM6LQg==
X-Received: by 2002:a17:902:7591:: with SMTP id
 j17mr35215640pll.200.1559637596920; 
 Tue, 04 Jun 2019 01:39:56 -0700 (PDT)
Received: from localhost ([122.172.66.84])
 by smtp.gmail.com with ESMTPSA id z17sm4656763pfn.44.2019.06.04.01.39.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Jun 2019 01:39:56 -0700 (PDT)
Date: Tue, 4 Jun 2019 14:09:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] KVM: arm64: Drop 'const' from argument of vq_present()
Message-ID: <20190604083954.wf2q4h75uhx525yb@vireshk-i7>
References: <699121e5c938c6f4b7b14a7e2648fa15af590a4a.1559623368.git.viresh.kumar@linaro.org>
 <0adbeaff-bb5e-54cc-292e-62cb9f73cf50@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0adbeaff-bb5e-54cc-292e-62cb9f73cf50@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
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

On 04-06-19, 09:30, Marc Zyngier wrote:
> On 04/06/2019 05:43, Viresh Kumar wrote:
> > We currently get following compilation warning:
> > 
> > arch/arm64/kvm/guest.c: In function 'set_sve_vls':
> > arch/arm64/kvm/guest.c:262:18: warning: passing argument 1 of 'vq_present' from incompatible pointer type
> > arch/arm64/kvm/guest.c:212:13: note: expected 'const u64 (* const)[8]' but argument is of type 'u64 (*)[8]'
> 
> Using which toolchain? My GCC 8.3.0 doesn't say anything.

I haven't updated mine since a long time it seems :)

aarch64-linux-gnu-gcc (Linaro GCC 4.9-2015.05) 4.9.3 20150413 (prerelease)

-- 
viresh
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
