Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4929F4B2B6A
	for <lists+kvmarm@lfdr.de>; Fri, 11 Feb 2022 18:11:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7FF9A41173;
	Fri, 11 Feb 2022 12:11:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DYkjVmYsUtpT; Fri, 11 Feb 2022 12:11:25 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 08D5049F38;
	Fri, 11 Feb 2022 12:11:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C04FF40B41
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Feb 2022 12:11:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H1JAYgZ2Mdzx for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Feb 2022 12:11:20 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F610408BA
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Feb 2022 12:11:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644599479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+fH+egNgtrcTN/yo9SnJEosgMHxBzskBNmKpy4+ujzU=;
 b=g9d44WAjUQIf0RQ446oky42MOIMkrnJ5+PkDWXZOm7Migq8zxYlBuoCN4fVISsUlv+4brf
 zXaegeRWm6TDAFE6OrYJje+f0fsgfTfbBEyQiCO+kDAt4O9Qd+96V9KQHqLBhlZcKy03WJ
 udMGj8Kg8AjHYNA02MrF/vo3mUpL6w0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-307ITZqVOn6qkZ03D8pX6g-1; Fri, 11 Feb 2022 12:11:18 -0500
X-MC-Unique: 307ITZqVOn6qkZ03D8pX6g-1
Received: by mail-ej1-f70.google.com with SMTP id
 q3-20020a17090676c300b006a9453c33b0so4338598ejn.13
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Feb 2022 09:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=+fH+egNgtrcTN/yo9SnJEosgMHxBzskBNmKpy4+ujzU=;
 b=JasN9XoUME+i0MlqjxSYTvahgIcaAs1JAeU5KPIhdnc6zCnrh+TPNS+VsZfMJbh/ko
 z4xRgFdF85pWY2zlbCLUll/Xr2rfSDJIzrApnTLsF/H8gnqTbtyoI22j7vyyc/R96k6R
 p8gIZH7hC4594eQFCumlUnWT0D5EZadn2AyHqeamVWe8dc24O1iKheSrIOH5qLjR3oul
 0Rq6xr4UHMZpPtm/CGx+f+JuoBfyWNre9J5uR5gWTDotuRcmeieGjxU9Gf06leofzRze
 7FqBfTwNmrtFTJzJAem6J66yBCOaXeRXbOQa5/zHbuKtYLNb0TYDJ5RJKqHErfEkZkQN
 5WYg==
X-Gm-Message-State: AOAM53272Es1eB/H1y75Sa8WHtIbexFVl4OjlKMTqNfexoy+Dk8CKv+S
 WUwq+0slbiumRmD5Q4S7ApQugSwSj1DaHHW6u96IzBja+IkmoZXeZJwE6hdfeRBzpk/koZcuS3R
 55i0yIdtwvNp0Qg8rdNFyj816
X-Received: by 2002:aa7:c418:: with SMTP id j24mr2924132edq.451.1644599477487; 
 Fri, 11 Feb 2022 09:11:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpwFcUYYNnkvRcA/m4GHfj0uOwr5SJjb7uoU4Dl3Wm/sXyNsM619P3/nsOD/l0UxZdqTWSEg==
X-Received: by 2002:aa7:c418:: with SMTP id j24mr2924106edq.451.1644599477274; 
 Fri, 11 Feb 2022 09:11:17 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id s16sm9313882edy.70.2022.02.11.09.11.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Feb 2022 09:11:16 -0800 (PST)
Message-ID: <e84b11cc-5961-f8a2-78cb-a3861debe82d@redhat.com>
Date: Fri, 11 Feb 2022 18:11:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [GIT PULL] KVM/arm64 fixes for 5.17, take #3
To: Marc Zyngier <maz@kernel.org>
References: <20220211111129.1180161-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220211111129.1180161-1-maz@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2/11/22 12:11, Marc Zyngier wrote:
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-fixes-5.17-3

Pulled, thanks.

Paolo

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
