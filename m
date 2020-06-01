Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF121EA002
	for <lists+kvmarm@lfdr.de>; Mon,  1 Jun 2020 10:27:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6AB924B253;
	Mon,  1 Jun 2020 04:27:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R6ElNhCHbMSp; Mon,  1 Jun 2020 04:27:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B0044B244;
	Mon,  1 Jun 2020 04:27:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2AB244B241
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Jun 2020 04:27:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ha5vdlELWo+i for <kvmarm@lists.cs.columbia.edu>;
 Mon,  1 Jun 2020 04:27:09 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C59F54B22E
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Jun 2020 04:27:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591000029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4lu/dxD8ezXYOJnBc6Dn7bo6tW00B3HpYIm/3Tes6k=;
 b=SlziDNVMDqWrW6gfiyWjJEeTOFcfLyuuVLBfQEkoV3dRQqKHp9dKLI8TvDz1jSeOw6OOBH
 T0CuyuZ+YLOnYuBKMYv77EPSMMmUTI4lKeXNq0NEUkNLrI5YoWr/fCjBadNVg75xJCGWk3
 yc/n2rOgSsGQtZMZklzcDZ+DKSV+3LQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-evcK2P6hOwKXk24spAXl6A-1; Mon, 01 Jun 2020 04:27:05 -0400
X-MC-Unique: evcK2P6hOwKXk24spAXl6A-1
Received: by mail-wm1-f72.google.com with SMTP id 11so2671535wmj.6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 01 Jun 2020 01:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E4lu/dxD8ezXYOJnBc6Dn7bo6tW00B3HpYIm/3Tes6k=;
 b=qdPLNmpwVMmqc9BhdPgbsFmBGtydao78g33W5vspvG9W64LDn/Br5rkSLCUGJ5Fxri
 j4fzt/F9q2As+/jH/uPJ96xZtrYewVH4Li1wgXQt9NDJyGsktd4IZFgD8ZUGOWqNk4VW
 Uvgqs1ogCnlnNOGKFxe3rdS5ja2q2/VY0yomHHniIUTV2tUYooXx1YzUQsttVlMhhjT0
 KAF9Iq1Iopu6bA1T3NcFMbbPO1C/R/WXFO5ZAkvHUxh0OlKfBL0dbdijAyY+vbP6wgSC
 xaC1ACbHr3J2PM7X7Qk5GWTdz0QbQ+CHO4AL1mYuePfzkGHtzXI08e5mEVLGvL4nYqgs
 wqpA==
X-Gm-Message-State: AOAM530Bq0EdZnaIedlwVSUjj09me2jYbh4gybImaRxbmdza754Gg0kd
 6RdHUGHiE2SPLd30M9FaVRAvwc4SMGOoKdq6BIbEGE/XforpOVlaZ68pgaBnxTNtfFZqRJYB23d
 9Jc/OecW5vlPITyX30YC1bK1N
X-Received: by 2002:a5d:4bcb:: with SMTP id l11mr22357432wrt.363.1591000024517; 
 Mon, 01 Jun 2020 01:27:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx32HOgFCCtByd40naAgUYbnAHE2Ln8h8s37CuU7DmFEmUw7hzr40v2F7kG19gUrQdUe0+aLQ==
X-Received: by 2002:a5d:4bcb:: with SMTP id l11mr22357394wrt.363.1591000024205; 
 Mon, 01 Jun 2020 01:27:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e044:3d2:1991:920c?
 ([2001:b07:6468:f312:e044:3d2:1991:920c])
 by smtp.gmail.com with ESMTPSA id h137sm11582353wme.0.2020.06.01.01.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 01:27:03 -0700 (PDT)
Subject: Re: [GIT PULL] KVM/arm64 updates for Linux 5.8
To: Marc Zyngier <maz@kernel.org>
References: <20200529160121.899083-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <32adb91d-c80c-743e-fe8f-57aee08140c4@redhat.com>
Date: Mon, 1 Jun 2020 10:27:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200529160121.899083-1-maz@kernel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Jiang Yi <giangyi@amazon.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On 29/05/20 18:00, Marc Zyngier wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-5.8

Pulled, thanks (to kvm/queue only for now).

Paolo

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
