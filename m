Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4AD1D4C07
	for <lists+kvmarm@lfdr.de>; Fri, 15 May 2020 13:03:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C8CCB4B418;
	Fri, 15 May 2020 07:03:03 -0400 (EDT)
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
	with ESMTP id G8WAOMW+-Om0; Fri, 15 May 2020 07:03:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C70C24B4AD;
	Fri, 15 May 2020 07:02:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ED3664B49E
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 May 2020 07:02:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yP09Z-mCRqKe for <kvmarm@lists.cs.columbia.edu>;
 Fri, 15 May 2020 07:02:58 -0400 (EDT)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E61DC4B418
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 May 2020 07:02:57 -0400 (EDT)
Received: by mail-wr1-f67.google.com with SMTP id j5so3066536wrq.2
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 May 2020 04:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QSEyQaq4LQecf0jyORsCF74hs8fmG+5qsCygtQRV5Dg=;
 b=Iuwv0st6tBfu2N1oXCtOhkcayvgqQMZupIvuQ2VGVv1/w1cebSJ+5Tf9lEm8kv4Of5
 VKUNqoghQw0xMwQ+iW365XX0XBTte7eaFcbQo5WX6k5T6R72gIUdlcCpSO6Cykl622ym
 upplDZVGF5MEy0WOV6XukDee6uz/yvuFu++aEfenRKuQQUB47C+uzX5AfNtVc4z8kz6e
 U2JJBHvOQpPCV5kDVPnZH1Saop0L8AeGY2XSLhBfrUTHh8rHYkwBbK/AnlpgnLVIz9xe
 HqGGHea8OOioDCvS7+IpU9SrBjQHhfuKNpwa6CKeyX4zSKbG/L5Q7eUMYp53DinKjgqK
 dB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QSEyQaq4LQecf0jyORsCF74hs8fmG+5qsCygtQRV5Dg=;
 b=D7nOXe3aCteZ4QqQQMi67SA/nIR9rsnZns19KpQ79HI0O97Na8j6s3pupMSrdNTGYB
 3HRpZwqIPS/aU7VOcECaWdQCjPSYYQAF6MnKxfHO41MYComOU5C9IQlJaOaKApzOR0SO
 hdD2eij7cMrOz1/1T5WeAGYNeQ3/YMS1Uv0wvgiPMFUEZyQIPBlnNjtGkluP4QhGXX4U
 rNprP48M/lsXiEMRp8yvGEGt6V7EMfRWYHArM6WIlWQRaGu95NQuzK/qeY/UbYH9YT9K
 IXZtdUHAX2XquBjWvNR7vsdAu1/Uu8P6Tj4XlgnGWf8PymdUx2CWk+5n716fQoTbJJXl
 dL4w==
X-Gm-Message-State: AOAM533bpcYP7azQ3q9TbS665D4YmMTkG+NkjedytE5WSxNOr9lqChD7
 82sm6OQ9hgL4LyxL5rwTRKH3kQ==
X-Google-Smtp-Source: ABdhPJxdZw/B+gueDnbAmXpzPy0/wjSgamnTKKreYvMlu/5kVJi8yd7clMYiq36nVcXiMdvgBkF7tA==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr3785390wrs.350.1589540576609; 
 Fri, 15 May 2020 04:02:56 -0700 (PDT)
Received: from dbrazdil-macbookpro.roam.corp.google.com
 ([2a01:4b00:8523:2d03:d11b:f847:8002:7411])
 by smtp.gmail.com with ESMTPSA id z3sm3368475wrm.81.2020.05.15.04.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 04:02:55 -0700 (PDT)
From: David Brazdil <dbrazdil@google.com>
X-Google-Original-From: David Brazdil
 <dbrazdil@dbrazdil-macbookpro.roam.corp.google.com>
Date: Fri, 15 May 2020 12:02:54 +0100
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Use cpus_have_final_cap for has_vhe()
Message-ID: <20200515110254.cxmng6u2qnnvwpya@dbrazdil-macbookpro.roam.corp.google.com>
References: <20200513103828.74580-1-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200513103828.74580-1-maz@kernel.org>
Cc: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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

Hi Marc,

> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: David Brazdil <dbrazdil@google.com>

Thanks, this is really helpful for the 'Split off nVHE code' series. Tested
them together and things seem to work just fine.

David
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
