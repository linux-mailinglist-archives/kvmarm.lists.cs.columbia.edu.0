Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 87862657FC
	for <lists+kvmarm@lfdr.de>; Thu, 11 Jul 2019 15:40:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A0734A4CD;
	Thu, 11 Jul 2019 09:40:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VNoyEsIXWPjh; Thu, 11 Jul 2019 09:40:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 291344A4FB;
	Thu, 11 Jul 2019 09:40:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 614014A4F3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 09:40:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rutmpc5sloah for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Jul 2019 09:40:22 -0400 (EDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 887A14A4CD
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 09:40:22 -0400 (EDT)
Received: by mail-wr1-f43.google.com with SMTP id g17so6360251wrr.5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 06:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FnSXGXReWdj1dwt4PqYkheiL50PJemd4VIlhtbzAQt8=;
 b=T5dau7uRSXFvChH+bturOjV4jx020bU0rgJ20o7XYVtsY7OrvuaLVaNuGSHDzU2tT7
 8kOONTvFxVgTTR/GkXlHnDObb4CQqunetNOnDuc4ZSRAGPGTSbTeLBAzUUqvtS0KFHTd
 q+p6KXdNK7fMVjDecrmZwLIUrOJ+4AeTVEdQfp5wyoqtTqajw8pV48SHoUcZLPLwnxvt
 oJJlktolpCHBf9g5FcZYELF9eMZVM+WxHp1XwMZ2bu0JKzsFaCtdMu8C7vpx4j8Tv77p
 0dEuhpEMxxu9u693rjCeEPTp9n3Z2xYRHs/t+7QsRH0FS+H50n9H0yCxWyC14soM5fzM
 9bfg==
X-Gm-Message-State: APjAAAUpEyCb7JtzdojId9vzWdTjsL5AFxucG2g+qHn9HyXZneA0u+Hp
 +s2JpTs4X+EXU1BBwQWaMCqm2A==
X-Google-Smtp-Source: APXvYqyShV9fbckDIWGQ0EkgfblduUbng9/MP66ZdhXZaEdrkN9dkmEju62XgU7X98NYyExpOgwWZA==
X-Received: by 2002:adf:e843:: with SMTP id d3mr5517125wrn.249.1562852421455; 
 Thu, 11 Jul 2019 06:40:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id e3sm5300954wrt.93.2019.07.11.06.40.19
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 06:40:20 -0700 (PDT)
Subject: Re: [GIT PULL] KVM/arm updates for Linux 5.3
To: Marc Zyngier <marc.zyngier@arm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>
References: <20190709122507.214494-1-marc.zyngier@arm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7f0bdfc0-d450-5466-ba0f-34c52d872e91@redhat.com>
Date: Thu, 11 Jul 2019 15:40:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709122507.214494-1-marc.zyngier@arm.com>
Content-Language: en-US
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 Andre Przywara <andre.przywara@arm.com>, Steven Price <steven.price@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On 09/07/19 14:24, Marc Zyngier wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-5.3

Pulled, thanks!

Paolo
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
