Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BEF15397331
	for <lists+kvmarm@lfdr.de>; Tue,  1 Jun 2021 14:27:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 389A049FE6;
	Tue,  1 Jun 2021 08:27:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wj6TqG42Ti3u; Tue,  1 Jun 2021 08:27:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DEE1949E8A;
	Tue,  1 Jun 2021 08:27:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3A64749E8A
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Jun 2021 08:27:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9xenq1RH-Hb3 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  1 Jun 2021 08:27:37 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 990DD49DE3
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Jun 2021 08:27:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622550457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQvZyUoXVmIb3zfNjpz2vDPXvvVv3DHJGgPXj4NfCyk=;
 b=IbIsgXdRAW5WlKb0MFb0vB31/hosFjsR6eGF0Ck+tHP2zD/BzDX98gGJqZx3RGjOOlFgqv
 AKA10z2CospU24msgOU8o/gyTPZ66V+wbgFzGrsgqEv1QGDNt2aMOrCqTOYTLAMfsv7BGp
 t1sPpgO8Qk4FSKO4Aq05ZNPTrCpNfJo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-SxCoalMrMiS4IXX3JS5LYw-1; Tue, 01 Jun 2021 08:27:33 -0400
X-MC-Unique: SxCoalMrMiS4IXX3JS5LYw-1
Received: by mail-ed1-f69.google.com with SMTP id
 y7-20020aa7ce870000b029038fd7cdcf3bso4211808edv.15
 for <kvmarm@lists.cs.columbia.edu>; Tue, 01 Jun 2021 05:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=lQvZyUoXVmIb3zfNjpz2vDPXvvVv3DHJGgPXj4NfCyk=;
 b=j2wiZ3zvKfiNR7yMcIBAn2hgDYa9fTvC5Ezxdd/RGJ0c7tOErTc2QgKGi1aKB8BezG
 auj3vgGre0vi6P7vCz2sSFCz6lTK5FnwRM9rwbK9PoahmIamhyzFZLltAR30JA0LVZuZ
 gjgmDMq/gTAkR9a5brKv2uyVo9/8kmOLKtQ2grLSdhtWq5g1d9+61rhfrhdHqguCChC6
 Dqh5nSDkc4JPUr4kva5Va7B5HDsQcimy8oSoyJFTdd1pWX8d1cqQ2bNqGWIsr3P8UzG5
 UUbFL7+XFksjogRcXITKhNZ1MVF9jKvX3zHs2abre5sNoyjEjLgHzf86XcF07M0A4AoF
 ymYg==
X-Gm-Message-State: AOAM531i+uwgYQr6t1rMJ6CQaTddMBooQ0wW2dliTpgeM4l2+v3XXQ+T
 df4BwtIXAQli/IHjEunRGxxIINIsXxGPwlnw7Cr+eAf5v+v6a9Erk4rbOXV3nivuldW0u9p1bCP
 s0vZWJ4Zlu5odIkf/b8cA+lbA
X-Received: by 2002:a05:6402:170e:: with SMTP id
 y14mr23743885edu.367.1622550452728; 
 Tue, 01 Jun 2021 05:27:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiKHS2wqpO00I6qpAmAouTmxfS631vP+B8lrpX5GWqTUpwzxbzb820iR2grCzdAC1TdTDGlA==
X-Received: by 2002:a05:6402:170e:: with SMTP id
 y14mr23743859edu.367.1622550452504; 
 Tue, 01 Jun 2021 05:27:32 -0700 (PDT)
Received: from gator.home (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
 by smtp.gmail.com with ESMTPSA id e24sm439285ejb.52.2021.06.01.05.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jun 2021 05:27:32 -0700 (PDT)
Date: Tue, 1 Jun 2021 14:27:30 +0200
From: Andrew Jones <drjones@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [kvm-unit-tests PATCH v2 2/4] scripts/arch-run: don't use
 deprecated server/nowait options
Message-ID: <20210601122730.ssdxx7ut6e25e4b5@gator.home>
References: <20210525172628.2088-1-alex.bennee@linaro.org>
 <20210525172628.2088-3-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20210525172628.2088-3-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maz@kernel.org, shashi.mallela@linaro.org,
 qemu-arm@nongnu.org, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Tue, May 25, 2021 at 06:26:26PM +0100, Alex Benn=E9e wrote:
> The very fact that QEMU drops the deprecation warning while running is
> enough to confuse the its-migration test into failing. The boolean
> options server and wait have accepted the long form options for a long
> time.
> =

> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Cc: Shashi Mallela <shashi.mallela@linaro.org>
> ---
>  scripts/arch-run.bash | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
