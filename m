Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFC6397403
	for <lists+kvmarm@lfdr.de>; Tue,  1 Jun 2021 15:22:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 979484A2E5;
	Tue,  1 Jun 2021 09:22:10 -0400 (EDT)
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
	with ESMTP id LP1qz3YpR4Im; Tue,  1 Jun 2021 09:22:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E8D304A19B;
	Tue,  1 Jun 2021 09:22:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DF25F4A17F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Jun 2021 09:22:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y4xLxIxZd2MX for <kvmarm@lists.cs.columbia.edu>;
 Tue,  1 Jun 2021 09:22:04 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C1A849F92
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Jun 2021 09:22:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622553723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ThmhXV5C1Mdx87JvqBPyBVcdeP2i7QEeRJhDPg8Jb0Y=;
 b=OAJ8O2B05uAS8ccRNbLzO0JW7waWSFZQc+Jswr3lNZZ51u5YG5O6UP6FJbZ1jbCvk9RFJF
 Oa//xopwZ2TfnPhJ95JvDOiWlh5Mdet5oWZeMikG+h4GTWOLpBZ404d+EN+/A2rLMA+0bs
 KS+5lqcck6IOjEjrUUnu8+j7qAzgdNI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-b3sRS6oyMha-PD6DzBtAKA-1; Tue, 01 Jun 2021 09:22:00 -0400
X-MC-Unique: b3sRS6oyMha-PD6DzBtAKA-1
Received: by mail-ed1-f72.google.com with SMTP id
 x8-20020aa7d3880000b029038fe468f5f4so2869151edq.10
 for <kvmarm@lists.cs.columbia.edu>; Tue, 01 Jun 2021 06:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ThmhXV5C1Mdx87JvqBPyBVcdeP2i7QEeRJhDPg8Jb0Y=;
 b=UWChPX9sL5kiJi05fzPxlcArWzV1qLItD79o437MaAbUbnYLPF8lDlVdFAftg+U4d7
 6NsX34wL2pxRj2aMNLWIxCumgy4R3MbuJeRFL4EqzsOrvAA7yaJCg+f7I0N7wW/EtWX2
 8+dF9hq18yJk4VFN68gQrf+RBC5efN8vYtOArNvK7bPnpO/9ZrV70pvYgHgC48HGDz2r
 lhFWPT+cgc2U1EpcKFAeRP+RzcQxdzyLRoWXgb6hf8vGG4dqoYd0t8h0AeSeMn7DnxMx
 c/dpbH7kAFHssxKweVUDC03p4D566qtzn1oLC+ol4car+viqioxpp+CuAgSIcNFTxL2Q
 ehiQ==
X-Gm-Message-State: AOAM530nQaSca49qYQeBNkkk+iKammh5YfJw9NJvF/73n0bVO4Bq6xd9
 i7WWZwxOxgHPYLLkczOvMSFRvACWCNlm88pg+Id//M6VIN1FOHTi7ZMeW7/3jrcc7YR1F3M4uTu
 4SIOzYRJwTnH6vp5tFaw5pwyu
X-Received: by 2002:a50:fd13:: with SMTP id i19mr7558995eds.280.1622553719289; 
 Tue, 01 Jun 2021 06:21:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwib9IzYrXbEw79+Z8nE2OguJl12IzGR+VIrSFD6C5CbyzCFWlk9D3q1IvxJWKKa0r/vLCqGw==
X-Received: by 2002:a50:fd13:: with SMTP id i19mr7558970eds.280.1622553719129; 
 Tue, 01 Jun 2021 06:21:59 -0700 (PDT)
Received: from gator.home (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
 by smtp.gmail.com with ESMTPSA id nc26sm1596965ejc.106.2021.06.01.06.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jun 2021 06:21:58 -0700 (PDT)
Date: Tue, 1 Jun 2021 15:21:56 +0200
From: Andrew Jones <drjones@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [kvm-unit-tests PATCH v2 4/4] arm64: split
 its-migrate-unmapped-collection into KVM and TCG variants
Message-ID: <20210601132156.qtgcfkvlr7i7rf2d@gator.home>
References: <20210525172628.2088-1-alex.bennee@linaro.org>
 <20210525172628.2088-5-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20210525172628.2088-5-alex.bennee@linaro.org>
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

On Tue, May 25, 2021 at 06:26:28PM +0100, Alex Benn=E9e wrote:
> When running the test in TCG we are basically running on bare metal so
> don't rely on having a particular kernel errata applied.
> =

> You might wonder why we handle this with a totally new test name
> instead of adjusting the append to take an extra parameter? Well the
> run_migration shell script uses eval "$@" which unwraps the -append
> leading to any second parameter being split and leaving QEMU very
> confused and the test hanging. This seemed simpler than re-writing all
> the test running logic in something sane ;-)

Yes, bash is a pain for this. I may try to get migration with more than
one parameter to work at some point though. But, for generally determining
if a unit test is running with tcg or with kvm, we have the QEMU_ACCEL
environment variable. So you could just do getenv("QEMU_ACCEL") in the
unit test. However, I wouldn't use it for this case, since the purpose is
just to force errata to be ignored. We have the "ERRATA_FORCE" environment
variable for that already. You can set it yourself, e.g.

 $ ERRATA_FORCE=3Dy tests/its-migration

or, if you plan to run all tests, then with

 $ ./run_tests.sh -a

but that also runs nodefault tests. Maybe we should teach run_tests.sh
to always set ERRATA_FORCE=3Dy when running with TCG?

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
